require "test_helper"

class BoardPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get board_posts_index_url
    assert_response :success
  end

  test "should get new" do
    get board_posts_new_url
    assert_response :success
  end

  test "should get create" do
    get board_posts_create_url
    assert_response :success
  end
end
