require "test_helper"

class BoardPostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get board_posts_path
    assert_response :success
  end

  test "should get new" do
    get new_board_post_path
    assert_response :success
  end
end
