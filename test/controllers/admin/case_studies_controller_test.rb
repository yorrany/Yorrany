# frozen_string_literal: true

require "test_helper"

class Admin::CaseStudiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @case_study = case_studies(:one)
  end

  test "should get new" do
    get new_admin_case_study_url
    assert_response :success
  end

  test "should create case_study" do
    assert_difference("CaseStudy.count") do
      post admin_case_studies_url, params: {
        case_study: {
          title: "Novo Case Study",
          tagline: "Uma tagline moderna",
          client: "Cliente Teste",
          role: "Product Designer",
          summary: "Resumo do case"
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should get edit" do
    get edit_admin_case_study_url(@case_study)
    assert_response :success
  end

  test "should update case_study" do
    patch admin_case_study_url(@case_study), params: {
      case_study: {
        title: "Título Atualizado"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should translate case_study" do
    with_stubbed_translation({ "title" => "Translated Title" }) do
      post translate_admin_case_study_url(@case_study)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy case_study" do
    assert_difference("CaseStudy.count", -1) do
      delete admin_case_study_url(@case_study)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
