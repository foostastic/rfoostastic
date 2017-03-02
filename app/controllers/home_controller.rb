class HomeController < ApplicationController
  def index
    users = User.all
    @ranking = users.sort do |a,b|
      b.get_total_value <=> a.get_total_value
    end
  end

  def login
    redirect_to '/auth/developer' and return unless Rails.env.production?
    redirect_to '/auth/google_oauth2'
  end

  def logout
    @_current_user = session[:current_user_id] = nil
    redirect_to root_url
  end
end
