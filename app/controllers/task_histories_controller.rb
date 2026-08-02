class TaskHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    family = current_user.families.first

    @task_logs = TaskLog
                   .joins(:family_member)
                   .where(family_members: { family_id: family.id })
                   .includes(:task, family_member: :user)
                   .order(completed_at: :desc)
                   .page(params[:page])
                   .per(10)
  end
end
