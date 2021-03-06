class SessionsController < ApplicationController
  before_action :redirect_logged_in_users, only: [:new]

  def new
  end

  def callback
    auth = request.env['omniauth.auth']

    user = User.find_and_update(auth) || User.create_with_omniauth(auth)

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
      redirect_to images_path
    end
  end
end
