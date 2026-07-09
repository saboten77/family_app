require "test_helper"

class FamilyJoinsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_family_join_url
    assert_response :success
  end

  test "should get create" do
    post family_joins_url
    assert_response :success
  end
end
