# frozen_string_literal: true

require "test_helper"

class Admin::CertificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @certification = certifications(:one)
  end

  test "should get new" do
    get new_admin_certification_url
    assert_response :success
  end

  test "should create certification" do
    assert_difference("Certification.count") do
      post admin_certifications_url, params: {
        certification: {
          title: "Nova Certificação",
          issuer: "Linux Foundation",
          category: "Segurança",
          year: "2024",
          badge_code: "LFD101",
          credential_code: "ABC-123",
          credential_url: "https://example.com/cred",
          skills: "Security, JS"
        }
      }
    end

    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should update certification" do
    patch admin_certification_url(@certification), params: {
      certification: {
        title: "Certificação Atualizada"
      }
    }
    assert_redirected_to admin_path(locale: :'pt-PT')
  end

  test "should reorder certifications" do
    c1 = certifications(:one)
    c2 = certifications(:two)
    patch reorder_admin_certifications_url, params: { ordered_ids: [ c2.id, c1.id ] }
    assert_response :success
  end

  test "should translate certification" do
    with_stubbed_translation({ "title" => "Translated Cert" }) do
      post translate_admin_certification_url(@certification)
      assert_redirected_to admin_path(locale: :'pt-PT')
    end
  end

  test "should destroy certification" do
    assert_difference("Certification.count", -1) do
      delete admin_certification_url(@certification)
    end
    assert_redirected_to admin_path(locale: :'pt-PT')
  end
end
