class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :current_user

  private

  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @_current_season = Season.find_by(active: true)
    @_current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
    if @_current_user then
      @_current_user_season = UserSeason.create_for_session_if_not_exists(@_current_user, @_current_season)
    end
    @_current_user
  end

  def require_login
    unless current_user
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end
end
