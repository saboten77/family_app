class TaskLogsController < ApplicationController
  before_action :authenticate_user!

  def new
    @task_log = TaskLog.new(completed_at: Date.current)
    @tasks = Task.all

    if params[:task_id]
      @task_log.task_id = params[:task_id]
    end
  end

  def create
    @task_log = TaskLog.new(task_log_params)
    @task_log.family_member = current_user.family_members.first

    if @task_log.save
      family = current_user.families.first

      # 家事1件につきエネルギーを加算
      EnergyManager.new(family).add_task_energy

      redirect_to complete_task_logs_path
    else
      @tasks = Task.all
      render :new, status: :unprocessable_entity
    end
  end

  def complete
  end

  def index
    @task_logs = TaskLog
                   .includes(:task, :family_member)
                   .order(completed_at: :desc)
                   .page(params[:page])
                   .per(3)
  end

  private

  def task_log_params
    params.require(:task_log).permit(:task_id, :completed_at)
  end
end
