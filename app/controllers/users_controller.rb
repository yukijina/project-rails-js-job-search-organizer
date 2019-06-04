class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  #signup form
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:user][:admin] == "1"
      if params[:user][:admin_code] == "007"
        @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:message] = "Admin code is not correct. Please try again or signup as non-admin."
       render 'new'
      end
    elsif params[:user][:admin] == "0"
        @user.admin_code = nil
        @user && @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])

  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :admin, :admin_code)
    end

end
