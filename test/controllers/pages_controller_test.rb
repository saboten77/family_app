require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get new_contact_path
    assert_response :success
  end

  test "should get privacy" do
    get privacy_path
    assert_response :success
  end
end
