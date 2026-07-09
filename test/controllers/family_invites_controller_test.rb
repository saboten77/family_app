require "test_helper"

class FamilyInvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get family_invites_show_url
    assert_response :success
  end
end
