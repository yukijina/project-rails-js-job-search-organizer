class SessionsController < ApplicationController

  #root
  def home
  end

  #login - form
  def new
    @user = User.new
    if logged_in?
      flash[:message] = "You are alrady logged in"
      redirect_to user_path(@user)
    else
      render 'login'
    end
  end

  #login
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:message] = "Please enter the correct information."
      redirect_to login_path
    end
  end

  #login with google
  def googleAuth
    @user = User.from_omniauth(auth)
    @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  #logout
  def destroy
    if session[:user_id].present?
      session.delete :user_id
      flash[:message] = "You're successully logged out"
      redirect_to '/'
    else
      session[:user_id] = nil
    end
  end

  private
    def user_params
      params.require(:users).permit(:username, :email, :password)
    end

    def auth
      #Get access tokens from google server
      request.env['omniauth.auth']
    end

end
