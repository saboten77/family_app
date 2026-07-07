require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get accounts_show_url
    assert_response :success
  end

  test "should get edit_profile" do
    get accounts_edit_profile_url
    assert_response :success
  end

  test "should get edit_email" do
    get accounts_edit_email_url
    assert_response :success
  end

  test "should get edit_password" do
    get accounts_edit_password_url
    assert_response :success
  end
end
