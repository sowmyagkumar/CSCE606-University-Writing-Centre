class TasksController < ApplicationController
  def new
  end

  def create
    @user = User.first
    @tasks = @user.tasks.create(task_params)
    flash[:notice] = "Created Tasks"
    redirect_to users_path
  end

  def show
  end

  def edit
  end

  protected
  def task_params
    params.require(:task).permit(:title, :email, :desc, :target_date, :target_value, :measure, :create_date)
  end
end
