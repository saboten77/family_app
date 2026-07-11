class TaskCategoriesController < ApplicationController
  def index
    @task_categories = TaskCategory.all
  end
end
