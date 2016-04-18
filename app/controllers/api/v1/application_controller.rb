class Api::V1::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find_by_valid_token(access_token).first
  end

  def logged_in?
    User.find_by_valid_token(access_token).first.present?
  end

  def access_token
    request.headers['HTTP_ACCESS_TOKEN'] || params[:access_token]
  end

  def authenticate
    unless logged_in?
      respond_to do |format|
        format.json { render nothing: true, status: :unauthorized }
      end
    end
  end
end
