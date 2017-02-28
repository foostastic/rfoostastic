class HomeController < ApplicationController
  def index
    users = User.all
    users.sort do |a,b|
      b.get_total_value <=> a.get_total_value
    end
    @ranking = users
  end
end
