# frozen_string_literal: true

require "test_helper"

class AutoTranslateJobTest < ActiveJob::TestCase
  test "translates attributes and saves translations in mobility" do
    case_study = CaseStudy.new(title: "Design System Global", summary: "Resumo em Português")
    case_study.skip_auto_translate = true
    Mobility.with_locale(:'pt-PT') do
      case_study.title = "Design System Global"
      case_study.summary = "Resumo em Português"
    end
    case_study.save!

    fake_translations = { "title" => "Global Design System", "summary" => "Summary in English" }
    with_stubbed_translation(fake_translations) do
      AutoTranslateJob.perform_now("CaseStudy", case_study.id, :'pt-PT')
    end

    case_study.reload

    Mobility.with_locale(:'pt-PT') do
      assert_equal "Design System Global", case_study.title
    end
    Mobility.with_locale(:en) do
      assert_equal "Global Design System", case_study.title
      assert_equal "Summary in English", case_study.summary
    end
    Mobility.with_locale(:es) do
      assert_equal "Global Design System", case_study.title
    end
  end

  test "gracefully handles non-existent records without raising error" do
    assert_nothing_raised do
      AutoTranslateJob.perform_now("CaseStudy", 999_999_999, :'pt-PT')
    end
  end
end
