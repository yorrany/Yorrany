require 'net/http'
require 'uri'
require 'json'

class AutoTranslateJob < ApplicationJob
  queue_as :default

  def perform(class_name, record_id)
    record = class_name.constantize.find_by(id: record_id)
    return unless record

    # Find which attributes are translated by Mobility
    translated_attrs = record.class.mobility_attributes
    return if translated_attrs.empty?

    api_key = "AQ.Ab8RN6K1QtXoiJmTxbmlyHGfX2zBhjzm4I7Az2_b88fsmm6fbA"
    url = URI("https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=#{api_key}")

    Mobility.with_locale(:'pt-BR') do
      to_translate = {}
      translated_attrs.each do |attr|
        val = record.public_send(attr)
        to_translate[attr] = val if val.present?
      end
      
      return if to_translate.empty?

      # Translate to English
      en_payload = build_payload(to_translate, "Translate the following JSON values from Portuguese to English. Return ONLY valid JSON with the exact same keys. Do not return anything else.")
      en_res = fetch_translation(url, en_payload)
      
      # Translate to Spanish
      es_payload = build_payload(to_translate, "Translate the following JSON values from Portuguese to Spanish. Return ONLY valid JSON with the exact same keys. Do not return anything else.")
      es_res = fetch_translation(url, es_payload)

      record.skip_auto_translate = true

      Mobility.with_locale(:en) do
        en_res.each { |k, v| record.public_send("#{k}=", v) } if en_res
      end
      
      Mobility.with_locale(:es) do
        es_res.each { |k, v| record.public_send("#{k}=", v) } if es_res
      end

      # For pt-PT, just copy pt-BR
      Mobility.with_locale(:'pt-PT') do
        to_translate.each { |k, v| record.public_send("#{k}=", v) }
      end

      record.save!
    end
  end

  private

  def build_payload(data, instruction)
    {
      contents: [
        {
          parts: [
            { text: "#{instruction}\n\n#{data.to_json}" }
          ]
        }
      ]
    }.to_json
  end

  def fetch_translation(url, body)
    req = Net::HTTP::Post.new(url)
    req['Content-Type'] = 'application/json'
    req.body = body

    res = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(req)
    end
    
    return nil unless res.is_a?(Net::HTTPSuccess)
    
    parsed = JSON.parse(res.body)
    text = parsed.dig("candidates", 0, "content", "parts", 0, "text") || ""
    
    # Extract JSON object from potential markdown
    match = text.match(/\{.*\}/m)
    return nil unless match
    
    text = match[0]
    
    JSON.parse(text)
  rescue StandardError => e
    Rails.logger.error "Translation failed: #{e.message}"
    nil
  end
end
