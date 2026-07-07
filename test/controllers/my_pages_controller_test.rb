require "test_helper"

class MyPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get mypage_path
    assert_response :success
  end
end
