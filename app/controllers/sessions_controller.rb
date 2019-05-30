class SessionsController < ApplicationController

  #root
  def home
  end

  #login - form
  def new
    @user = User.new
    if logged_in?
      flash[:message] = "You are alrady logged in"
      redirect_to user_path(current_user)
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
      flash[:message] = "Email and Password do not match. Please enter the correct inforamtion."
      redirect_to login_path
    end
  end

  #logout
  def destroy
    session.delete :user_id
    redirect_to '/'
  end

  private
    def user_params
      params.require(:users).permit(:username, :email, :password)
    end
end
