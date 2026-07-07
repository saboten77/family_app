require "test_helper"

class FamiliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get families_path
    assert_response :success
  end
end
