require "test_helper"

class TaskLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get task_logs_new_url
    assert_response :success
  end

  test "should get create" do
    get task_logs_create_url
    assert_response :success
  end
end
