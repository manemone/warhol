class ApiKeysController < LoggedInController
  def update
    current_user.reset_api_key!
    redirect_to user_url(current_user), notice: "Hooray! Your new access token has been generated."
  rescue
    redirect_to user_url(current_user), alert: "Failed to reset your api key."
  end
end
