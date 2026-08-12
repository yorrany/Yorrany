require "test_helper"

class CvControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get cv_show_url
    assert_response :success
  end
end
