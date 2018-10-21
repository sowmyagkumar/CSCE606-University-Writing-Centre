class TasksController < ApplicationController
  def new
    @user = User.first
  end

  def create
    @user = User.find(params[:user_id])
    @tasks = @user.tasks.create(task_params)
    flash[:notice] = "Created Tasks"
    redirect_to users_path
  end

  def show
    @user = User.first
    @task = @user.tasks.find(params[:id])
  end

  def update_task
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.current_value = params[:task][:current_value]
    @task.save
    redirect_to user_task_path(@user,@task)
  end

  def edit
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.update_attributes!(task_params)
    redirect_to user_task_path(@user,@task)
  end

  def destroy
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:notice] = "Task Destroyed successfully"
    redirect_to users_path
  end

  protected
  def task_params
    params.require(:task).permit(:title, :email, :desc, :target_date, :target_value, :measure, :create_date)
  end
end
