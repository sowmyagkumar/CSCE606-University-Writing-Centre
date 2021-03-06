class TasksController < ApplicationController

  before_action :login_req

  def new
    @user = User.find(session[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    task_params[:current_value] = 0
    @tasks = @user.tasks.new(task_params)
    if @tasks.save
      redirect_to users_path
    else
      flash[:error] = "Invalid fields #{@tasks.errors.full_messages}"
      render :new
    end
  end

  def show
    @user = User.find(session[:user_id])
    @task = @user.tasks.find(params[:id])
    @percent = (@task.current_value*100)/@task.target_value
  end

  def update_task
    @user = User.find(params[:user_id])
    @task = @user.tasks.find(params[:id])
    @task.current_value = params[:task][:current_value].to_i
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
    flash[:success] = "Task Destroyed successfully"
    redirect_to users_path
  end

  protected
  def task_params
    params.require(:task).permit(:title, :email, :desc, :target_date, :target_value, :measure, :create_date)
  end

  def login_req
    if session[:user_id]==nil
        redirect_to login_path
    end
  end
end
