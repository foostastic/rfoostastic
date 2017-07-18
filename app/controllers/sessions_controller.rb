class SessionsController < ApplicationController

  skip_before_action :verify_authenticity_token, :only => [:create]

  def create
    user = User.find_or_create_from_auth_hash(auth_hash)
    session[:current_user_id] = user.id
    redirect_to '/'
  end

  def auth_failure
    message = params.require(:message)
    strategy = params.require(:strategy)
    if strategy == 'google_oauth2' and message == 'invalid_credentials' and ENV["GOOGLE_LIMIT_DOMAINS"] then
      message = "You should login using one of the allowed domains"
    end
    flash[:error] = "Authorization denied: #{message}"
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
