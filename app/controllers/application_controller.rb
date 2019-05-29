class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_login

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id]
  end

  def require_login
    return head(:forbidden) unless session.include? :user_id
  end


end
