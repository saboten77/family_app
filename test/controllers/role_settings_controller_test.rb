require "test_helper"

class RoleSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get role_settings_edit_url
    assert_response :success
  end
end
