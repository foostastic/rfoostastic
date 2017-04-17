class HomeController < ApplicationController
  def index
    @ranking = nil
    users = UserSeason.where(season: @_current_season)
    if users.count > 0 then
      @ranking = users.sort do |a,b|
        b.get_total_value <=> a.get_total_value
      end
    end
  end

  def login
    redirect_to '/auth/developer' and return unless Rails.env.production?
    redirect_to '/auth/google_oauth2'
  end

  def logout
    @_current_user = session[:current_user_id] = nil
    @_current_user_season = nil
    redirect_to root_url
  end
end
