class TasksController < ApplicationController
  def index
    if params[:task_category_id]
      @task_category = TaskCategory.find(params[:task_category_id])
      @tasks = @task_category.tasks
    else
      @tasks = Task.all
    end
  end
end
