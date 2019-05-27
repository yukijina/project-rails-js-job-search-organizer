class SessionsController < ApplicationController

  #root
  def home
  end

  #login - form
  def new
    @user = User.new
    render 'login'
  end

  #login - create
  def create
    @user = User.find_by(id: params[:user][:id])
    if @user && @user.save
      session[:user_id] = @user.id
    else
      render 'login'
    end
  end

  #logout
  def destroy
  end

  private
    def user_params
      params.require(:users).permit(:username, :email, :password)
    end
end
