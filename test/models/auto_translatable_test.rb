# frozen_string_literal: true

require "test_helper"

class AutoTranslatableTest < ActiveSupport::TestCase
  test "computes translation status and missing locales correctly" do
    cs = CaseStudy.new
    cs.skip_auto_translate = true

    Mobility.with_locale(:'pt-PT') do
      cs.title = "Título PT"
    end
    Mobility.with_locale(:en) do
      cs.title = "Title EN"
    end
    cs.save!

    status = cs.translation_status
    assert status[:"pt-PT"]
    assert status[:en]
    refute status[:es]

    assert_includes cs.missing_translation_locales, :es
    refute_includes cs.missing_translation_locales, :en
    refute_includes cs.missing_translation_locales, :"pt-PT"
  end
end
