# frozen_string_literal: true

require "net/http"
require "uri"
require "json"

class TranslationService
  DEFAULT_MODELS = %w[
    gemini-2.5-flash
    gemini-2.0-flash
    gemini-1.5-flash
    gemini-3.7-flash
  ].freeze

  LOCALE_NAMES = {
    "pt-PT" => "Portuguese",
    "pt"    => "Portuguese",
    "en"    => "English",
    "es"    => "Spanish"
  }.freeze

  Result = Struct.new(:success, :translations, :error, keyword_init: true) do
    def success?
      !!success
    end
  end

  def self.translate_attributes(attributes_hash, from: :'pt-PT', to: :en, api_key: nil)
    new(api_key: api_key).translate_attributes(attributes_hash, from: from, to: to)
  end

  def initialize(api_key: nil)
    @api_key = api_key.nil? ? ENV.fetch("GEMINI_API_KEY", "") : api_key
  end

  def translate_attributes(attributes_hash, from: :'pt-PT', to: :en)
    # Reject non-hash or empty
    return Result.new(success: true, translations: {}, error: nil) if attributes_hash.blank?

    clean_data = attributes_hash.transform_keys(&:to_s).select { |_k, v| v.present? }
    return Result.new(success: true, translations: {}, error: nil) if clean_data.empty?

    if @api_key.blank?
      Rails.logger.warn "[TranslationService] GEMINI_API_KEY is not set. Skipping translation."
      return Result.new(success: false, translations: {}, error: "GEMINI_API_KEY is not configured")
    end

    from_name = LOCALE_NAMES[from.to_s] || from.to_s
    to_name   = LOCALE_NAMES[to.to_s]   || to.to_s

    instruction = <<~PROMPT
      You are a professional software and UX localization translator.
      Translate the following JSON values from #{from_name} to #{to_name}.
      Guidelines:
      1. Return ONLY valid JSON with the exact same keys as the input.
      2. Maintain all formatting, newlines, markdown, HTML, code tokens, tags, and special characters verbatim.
      3. For technical terms (e.g. Figma, Ruby on Rails, Design System, WCAG AAA, Front-End, Hotwire), maintain established industry terminology.
      4. Translate natural language text accurately, fluently, and idiomatically for #{to_name}.
      5. Output pure JSON without markdown fences.
    PROMPT

    payload = build_payload(clean_data, instruction)

    models_to_try = preferred_models
    last_error = nil

    models_to_try.each do |model_name|
      res = request_translation(model_name, payload)
      if res[:success]
        parsed = clean_and_parse_json(res[:text], clean_data.keys)
        if parsed.present?
          return Result.new(success: true, translations: parsed, error: nil)
        else
          last_error = "Failed to parse valid JSON matching expected keys from model #{model_name}"
        end
      else
        last_error = res[:error]
        Rails.logger.warn "[TranslationService] Model #{model_name} failed: #{res[:error]}. Trying next model if available."
      end
    end

    Result.new(success: false, translations: {}, error: last_error || "All translation attempts failed")
  end

  private

  def preferred_models
    custom_model = ENV["GEMINI_TRANSLATION_MODEL"].presence
    [ custom_model, *DEFAULT_MODELS ].compact.uniq
  end

  def build_payload(data, instruction)
    {
      contents: [
        {
          parts: [
            { text: "#{instruction}\n\n#{data.to_json}" }
          ]
        }
      ],
      generationConfig: {
        response_mime_type: "application/json",
        temperature: 0.1
      }
    }.to_json
  end

  def request_translation(model_name, body, max_attempts: 3)
    url = URI("https://generativelanguage.googleapis.com/v1beta/models/#{model_name}:generateContent?key=#{@api_key}")

    (1..max_attempts).each do |attempt|
      begin
        req = Net::HTTP::Post.new(url)
        req["Content-Type"] = "application/json"
        req.body = body

        res = Net::HTTP.start(url.hostname, url.port, use_ssl: true, open_timeout: 10, read_timeout: 30) do |http|
          http.request(req)
        end

        if res.is_a?(Net::HTTPSuccess)
          parsed = JSON.parse(res.body)
          text = parsed.dig("candidates", 0, "content", "parts", 0, "text") || ""
          return { success: true, text: text, error: nil }
        elsif res.code.to_i == 429 && attempt < max_attempts
          sleep_duration = (2**attempt) * 0.5
          Rails.logger.warn "[TranslationService] 429 Rate limit on #{model_name}. Retrying in #{sleep_duration}s..."
          sleep(sleep_duration)
        else
          return { success: false, text: nil, error: "HTTP #{res.code}: #{res.body.to_s.truncate(200)}" }
        end
      rescue StandardError => e
        if attempt < max_attempts
          sleep(0.5)
        else
          return { success: false, text: nil, error: "#{e.class}: #{e.message}" }
        end
      end
    end

    { success: false, text: nil, error: "Request timed out or failed after #{max_attempts} attempts" }
  end

  def clean_and_parse_json(raw_text, expected_keys)
    return {} if raw_text.blank?

    text = raw_text.strip
    # Strip markdown code blocks if the model wrapped output in ```json ... ```
    text = text.gsub(/\A```(?:json)?\s*/i, "").gsub(/\s*```\z/, "").strip

    parsed = begin
      JSON.parse(text)
    rescue JSON::ParserError
      match = text.match(/\{[\s\S]*\}/)
      match ? JSON.parse(match[0]) : nil
    end

    return {} unless parsed.is_a?(Hash)

    # Filter only expected keys and stringify
    result = {}
    expected_keys.each do |key|
      str_key = key.to_s
      if parsed.key?(str_key) && parsed[str_key].present?
        result[str_key] = parsed[str_key].to_s
      end
    end

    result
  rescue StandardError => e
    Rails.logger.error "[TranslationService] JSON parsing error: #{e.message}"
    {}
  end
end
