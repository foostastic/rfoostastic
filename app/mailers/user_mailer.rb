class UserMailer < ApplicationMailer

  helper ApplicationHelper

  def update_valuation(user_season, delta_user_value)
    @user_season = user_season
    @delta_user_value = delta_user_value
    mail(to: @user_season.user.email, subject: 'Updated valuation for you on Foostastic')
  end

end
