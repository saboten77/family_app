require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get account_path
    assert_response :success
  end

  test "should get edit_profile" do
    get account_profile_path
    assert_response :success
  end

  test "should get edit_email" do
    get account_email_path
    assert_response :success
  end

  test "should get edit_password" do
    get account_password_path
    assert_response :success
  end
end
