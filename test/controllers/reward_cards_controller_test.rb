require "test_helper"

class RewardCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in users(:one)

    get reward_cards_path

    assert_response :success
  end
end
