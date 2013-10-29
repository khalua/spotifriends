class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization :unless => :devise_controller?
  after_filter :store_location
  
  # check_authorization
  # before_filter :authenticate

  # private
  # def authenticate
  #   @auth = User.find(session[:user_id]) if session[:user_id].present?
  # end

  # def check_if_logged_in
  #   redirect_to(root_path) if @auth.nil?
  # end

  def store_location
    # store last url as long as it isn't a /users path
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end



  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
