require "test_helper"

class RoleSettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get edit" do
    get edit_role_setting_path
    assert_response :success
  end
end
