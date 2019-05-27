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

  end

  #logout
  def destroy
  end

end
