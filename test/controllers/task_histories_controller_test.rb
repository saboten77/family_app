require "test_helper"

class TaskHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get task_histories_index_url
    assert_response :success
  end
end
