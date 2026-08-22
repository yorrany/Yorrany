# frozen_string_literal: true

require "test_helper"

class Admin::AcademicBackgroundsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @academic_background = academic_backgrounds(:one)
  end

  test "should get new" do
    get new_admin_academic_background_url
    assert_response :success
  end

  test "should create academic_background" do
    assert_difference("AcademicBackground.count") do
      post admin_academic_backgrounds_url, params: {
        academic_background: {
          degree: "Bacharelado em Psicologia",
          institution: "Faculdade Santa Teresa",
          period: "2018 - 2023",
          field_of_study: "Psicologia Cognitiva",
          thesis: "Monografia sobre tomada de decisão",
          research_focus: "Comportamento Humano"
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should update academic_background" do
    patch admin_academic_background_url(@academic_background), params: {
      academic_background: {
        degree: "Mestrado em IHC"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should translate academic_background" do
    with_stubbed_translation({ "degree" => "B.Sc. in Psychology" }) do
      post translate_admin_academic_background_url(@academic_background)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy academic_background" do
    assert_difference("AcademicBackground.count", -1) do
      delete admin_academic_background_url(@academic_background)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
