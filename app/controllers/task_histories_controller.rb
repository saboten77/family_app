class TaskHistoriesController < ApplicationController
  def index
    @task_logs = TaskLog.includes(:task, :family_member)
                        .order(created_at: :desc)
  end
end
