class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end

  def authenticate_user!
    redirect_to root_path unless user_signed_in?
  end

  def current_user
    @current_user ||= User.find session[:user_id]
  end 

end
