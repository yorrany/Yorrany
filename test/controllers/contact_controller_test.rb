# frozen_string_literal: true

require "test_helper"

class ContactControllerTest < ActionDispatch::IntegrationTest
  test "should get vcard" do
    get vcard_url
    assert_response :success
    assert_equal "text/vcard", response.media_type
  end

  test "should reject contact submission with missing params" do
    post contact_url, params: { name: "", email: "", message: "" }, as: :json
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_equal false, json["success"]
  end

  test "should reject contact submission with invalid email" do
    post contact_url, params: { name: "Tester", email: "invalid-email", message: "Hello World" }, as: :json
    assert_response :unprocessable_entity
    json = JSON.parse(response.body)
    assert_equal false, json["success"]
  end

  test "should silently succeed for honeypot bot submissions without sending email" do
    post contact_url, params: { name: "Bot", email: "bot@spam.com", message: "Buy crypto", nickname: "gotcha" }, as: :json
    assert_response :success
    json = JSON.parse(response.body)
    assert_equal true, json["success"]
  end
end
