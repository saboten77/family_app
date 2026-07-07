require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get account_path
    assert_response :success
  end

  test "should get edit_profile" do
    get edit_account_profile_path
    assert_response :success
  end

  test "should get edit_email" do
    get edit_account_email_path
    assert_response :success
  end

  test "should get edit_password" do
    get edit_account_password_path
    assert_response :success
  end
end
