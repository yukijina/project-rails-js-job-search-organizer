class SessionsController < ApplicationController

  #root
  def home
  end

  #login - form
  def new
    @user = User.new
    render 'login'
  end

  #login
  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      #flash message
      render 'login'
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
