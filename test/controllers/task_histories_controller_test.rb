require "test_helper"

class TaskHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get task_histories_path
    assert_response :success
  end
end
