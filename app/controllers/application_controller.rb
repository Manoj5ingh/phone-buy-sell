class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  helper_method :render_error, :login!, :logged_in?, :current_user, :authorized_user?, :logout!
  rescue_from StandardError, :with => :render_stan_error
  
  def render_error(error)
    render json: error.response, status: error.response_code
  end

  def render_stan_error(error)
    render json: error.message, status: 500
  end  

  def login!
      session[:user_id] = @user.id
  end
  
  def logged_in?
    !!session[:user_id]
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def authorized_user?
    @user == current_user && !@user.nil?
  end
  
  def logout!
    session.clear
  end
end