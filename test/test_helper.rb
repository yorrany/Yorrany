# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def with_stubbed_translation(fake_translations = { "title" => "Translated", "summary" => "Translated", "role" => "Translated", "degree" => "Translated" })
      res = TranslationService::Result.new(success: true, translations: fake_translations, error: nil)
      original_method = TranslationService.method(:translate_attributes)
      TranslationService.define_singleton_method(:translate_attributes) do |*args, **kwargs|
        res
      end
      yield
    ensure
      TranslationService.define_singleton_method(:translate_attributes, original_method)
    end
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
