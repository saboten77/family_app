require "test_helper"

class RewardCardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reward_cards_index_url
    assert_response :success
  end
end
