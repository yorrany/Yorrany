require "test_helper"

class CvControllerTest < ActionDispatch::IntegrationTest
  test "should get show in English" do
    get "/cv/yorrany_cv_en"
    assert_response :success
    assert_equal "application/pdf", response.media_type
  end

  test "should get show in Portuguese" do
    get "/cv/yorrany_cv_pt"
    assert_response :success
    assert_equal "application/pdf", response.media_type
  end

  test "should get show in Spanish" do
    get "/cv/yorrany_cv_es"
    assert_response :success
    assert_equal "application/pdf", response.media_type
  end
end
