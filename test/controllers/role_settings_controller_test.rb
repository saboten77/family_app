require "test_helper"

class RoleSettingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get edit" do
    get role_settings_edit_url
    assert_response :success
  end
end
