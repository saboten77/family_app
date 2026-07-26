class TaskHistoriesController < ApplicationController
  def index
    @task_logs = TaskLog
                   .includes(:task, :family_member)
                   .order(completed_at: :desc)
                   .page(params[:page])
                   .per(10)
  end
end
