# frozen_string_literal: true

require "test_helper"

class TranslationServiceTest < ActiveSupport::TestCase
  class MockSuccessService < TranslationService
    def request_translation(model_name, body, max_attempts: 3)
      { success: true, text: '{"title": "My Title", "summary": "A short summary"}', error: nil }
    end
  end

  class MockMarkdownService < TranslationService
    def request_translation(model_name, body, max_attempts: 3)
      { success: true, text: "```json\n{\"title\": \"Clean Title\"}\n```", error: nil }
    end
  end

  test "returns empty result for blank data" do
    result = TranslationService.translate_attributes({}, from: :'pt-PT', to: :en)
    assert result.success?
    assert_equal({}, result.translations)
  end

  test "returns error result when API key is missing" do
    service = TranslationService.new(api_key: "")
    result = service.translate_attributes({ title: "Título" }, from: :'pt-PT', to: :en)
    refute result.success?
    assert_includes result.error, "GEMINI_API_KEY"
  end

  test "successfully parses structured JSON from Gemini API response" do
    service = MockSuccessService.new(api_key: "fake-key")
    result = service.translate_attributes({ title: "Meu Título", summary: "Um breve resumo" }, from: :'pt-PT', to: :en)
    assert result.success?
    assert_equal "My Title", result.translations["title"]
    assert_equal "A short summary", result.translations["summary"]
  end

  test "strips markdown code fences if returned by model" do
    service = MockMarkdownService.new(api_key: "fake-key")
    result = service.translate_attributes({ title: "Título Limpo" }, from: :'pt-PT', to: :en)
    assert result.success?
    assert_equal "Clean Title", result.translations["title"]
  end
end
