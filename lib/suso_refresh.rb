require_dependency 'suso_api'
require_dependency 'season_user_values'

class SusoRefresh

  def initialize(api = SusoApi.new)
    @api = api
  end

  def perform
    season_id = ENV["SUSO_FOOS_API_SEASON"] || "current"
    Player.transaction do
      players = @api.players
      seasons = @api.season(season_id)
      season = Season.find_by(foos_id: seasons["id"])
      raise "Season not found for foos_id #{seasons["id"]}" unless season
      initial_user_values = SeasonUserValues.create_from_season(season)
      seasons["divisions"].each do |division|
        players_info = @api.classification(division["id"])
        players_info.each do |player_info|
          player_id = player_info["player_id"]
          points = player_info["points"]
          player = Player.find_or_initialize_by(name: players[player_id.to_s]["name"], season: season)
          player.division = division["level"]
          player.division_title = division["title"]
          player.position = player_info["position"]
          player.points = points
          player.save
        end
      end
      end_user_values = SeasonUserValues.create_from_season(season)
      changed_user_values = end_user_values.diff(initial_user_values)
      send_mail_updates(changed_user_values) unless changed_user_values.empty?
    end
  end

  private

  def send_mail_updates(changed_user_values)
    Rails.logger.info "Found #{changed_user_values.size}"
    changed_user_values.each do |id, delta_user_value|
      user_season = UserSeason.find(id)
      if user_season.user.receives_mail? then
        UserMailer.update_valuation(user_season, delta_user_value).deliver_now
      end
    end
  end

end

