class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  #signup form
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if admin_params || non_admin_params
      if @user && @user.save
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render 'new'
      end
    elsif !admin_params && !non_admin_params
      flash[:message] = "Admin code is not correct."
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    respond_to do  |format|
      format.html { render :show }
      format.json { render json: @user}
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :admin, :admin_code)
    end

    def admin_params
      params[:user][:admin] == "1" && params[:user][:admin_code] == "007"
    end

    def non_admin_params
      params[:user][:admin] == "0"
    end

end
