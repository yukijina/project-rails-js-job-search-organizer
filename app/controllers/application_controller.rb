class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_login, :company_page_not_found, :admin?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id]
  end

  def require_login
    redirect_to root_path, alert: "You have to log in to see the contents." unless session.include? :user_id
  end

  def company_page_not_found
    flash[:message] = "Oops. Page not found."
    redirect_to companies_path
  end

  def admin?(user)
    true if user.admin == true
  end


end
