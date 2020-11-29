class SessionController < ApplicationController
  def create
    if session_params[:username].length==0
      render json: { 
        status: 401,
        errors: ['Please enter username']
      }
    elsif session_params[:password].length==0
      render json: { 
        status: 401,
        errors: ['Please enter password']
      }
    else
      @user = User.find_by(username: session_params[:username])
      if @user && @user.authenticate(session_params[:password])
        login!
        render json: {
          logged_in: true,
          user: @user
        }
      else
        render json: { 
          status: 401,
          errors: ['Invalid credentials. Please try again']
        }
      end
    end
  end
  def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user
      }
    else
      render json: {
        logged_in: false,
        message: 'no such user'
      }
    end
  end
  def destroy
    logout!
    render json: {
      status: 200,
      logged_out: true
    }
  end
  private
  def session_params
      params.require(:user).permit(:username, :password)
  end
end