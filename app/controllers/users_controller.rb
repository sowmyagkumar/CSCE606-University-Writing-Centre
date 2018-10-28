class UsersController < ApplicationController
  def new
    @user = User.new
  end
  before_action :login_req, only: [:index, :show]
  def index
    @quote = Quote.get
    @user = User.find(session[:user_id])
    @user_tasks = @user.tasks
  end

  def create
    @user = User.new(param_req)
    if @user.save
      flash[:success] = "Account Created successfully"
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:error] = "Invalid Credentials"
      redirect_to users_path
    end
  end

  def login
    # Only to render loginpage
  end

  def logout
    session.clear
    render :login
  end

  def auth
    authorized_user = User.authenticate(params[:user_auth][:email],params[:user_auth][:password])

    if authorized_user
      flash[:success] = "Welcome again"
      session[:user_id] = authorized_user.id
      redirect_to users_path
    else
      flash[:notice] = "Invalid Username or Password"
      render :login
    end
  end

  def show
  end

  protected

  def param_req
    params.require(:user).permit(:first_name, :email, :password, :last_name, :password_confirmation)
  end

  def params_req2
    params.require(:user_auth).permit(:email, :password)
  end

  def login_req
      if session[:user_id] == nil
        redirect_to login_path
      end
  end
end
