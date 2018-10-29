class UsersController < ApplicationController
  def new
    @user = User.new
  end
  before_action :login_req, only: [:index, :show, :update]
  def index
    @quote = Quote.get
    @user = User.find(session[:user_id])
    @user_tasks = @user.tasks
  end

  def create
    @user = User.new(param_req)
    if @user.save
      flash[:success] = "Account Created successfully, Please check your email for Verification"
    else
      flash[:error] = "Invalid Credentials"
    end
    render :login
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
      if !authorized_user.confirm
        flash[:error] = "Account has not been activated, Please check your email"
        redirect_to login_path
      end
      flash[:success] = "Welcome"
      session[:user_id] = authorized_user.id
      redirect_to users_path
    else
      flash[:notice] = "Invalid Username or Password"
      render :login
    end
  end

  def mail_confirm
    user = User.find_by(confirm_code: params[:conf])
    if user
      flash[:notice] = "Sorry that link has expired!"
      redirect_to new_user_path
    elsif !user.confirm_code
      redirect_to login_path
    else
      if user.set_confirm
        flash[:success] = "Account successfully activated, Please login!"
      else
        flash[:error] = "There appears to be a problem, please email advisor"
      end
    end
    render :login
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
