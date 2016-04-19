class SessionsController < ApplicationController
  before_action :redirect_logged_in_users, only: [:new]

  def new
  end

  def callback
    auth = request.env['omniauth.auth']

    user = User.find_by(provider: auth['provider'], uid: auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private
  
  def redirect_logged_in_users
    if logged_in?
      redirect_to new_image_path
    end
  end
end
