require "test_helper"

class CvControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get "/cv/yorrany_cv_en"
    assert_response :success
  end
end
