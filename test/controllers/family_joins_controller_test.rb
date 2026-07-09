require "test_helper"

class FamilyJoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get family_joins_new_url
    assert_response :success
  end

  test "should get create" do
    get family_joins_create_url
    assert_response :success
  end
end
