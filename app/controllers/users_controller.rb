class UsersController < ApplicationController
  def new
  end

  def index
     # TODO: have to change this when adding logins
    if session[:user_id] == nil
      session[:user_id] = 0
    end
    @user = User.first
    @user_tasks = @user.tasks
  end

  def show
  end
end
