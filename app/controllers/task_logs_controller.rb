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
    task_ids = params[:task_ids]
    family_member = current_user.family_members.first
    family = current_user.families.first

    if task_ids.blank?
      redirect_to tasks_path, alert: "家事を1つ以上選んでください"
      return
    end

    TaskLog.transaction do
      task_ids.each do |task_id|
        TaskLog.create!(
          task_id: task_id,
          completed_at: Date.current,
          family_member: family_member
        )

        # 家事1件につきエネルギーを加算
        EnergyManager.new(family).add_task_energy

        # 家事1件につきポイントを1加算
        current_user.increment!(:points)
      end
    end

    flash[:task_count] = task_ids.length
    redirect_to complete_task_logs_path
  rescue ActiveRecord::RecordInvalid
    redirect_to tasks_path, alert: "家事の記録に失敗しました"
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
