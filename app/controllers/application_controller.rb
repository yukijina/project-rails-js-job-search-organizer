class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_login, :company_page_not_found

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id]
  end

  def require_login
    #redirect with message
    return head(:forbidden) unless session.include? :user_id
  end

  def company_page_not_found
    flash[:message] = "Oops. Page not found."
    redirect_to companies_path
  end


end
