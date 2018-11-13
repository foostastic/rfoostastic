# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
require_dependency 'season_user_values'

class UserMailerPreview < ActionMailer::Preview
  def update_valuation
    delta = SeasonUserValues::Delta.new(
      SeasonUserValues::UserValue.new(200, {
        "1" => SeasonUserValues::ShareValue.new(100, "Pepe", 2),
        "2" => SeasonUserValues::ShareValue.new(100, "Paco", 1)
      }),
      SeasonUserValues::UserValue.new(210, {
        "1" => SeasonUserValues::ShareValue.new(90, "Pepe", 2),
        "2" => SeasonUserValues::ShareValue.new(120, "Paco", 1)
      }),
    )
    UserMailer.update_valuation(UserSeason.last, delta)
  end
end
