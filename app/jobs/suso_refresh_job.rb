require 'net/http'
require 'json'

class SusoRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    season_id = ENV["SUSO_FOOS_API_SEASON"] || "current"
    Player.transaction do
      players = suso_get "/players"
      seasons = suso_get "/seasons/#{season_id}"
      season = Season.find_by(foos_id: seasons["id"])
      raise "Season not found for foos_id #{seasons["id"]}" unless season
      seasons["divisions"].each do |division|
        players_info = suso_get "/divisions/#{division["id"]}/classification"
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
    end
  end

  private

  def suso_get(uri)
    base_url = ENV["SUSO_FOOS_API_URL"] || "https://suso.eu/foos/api/v1"
    uri = URI(base_url + uri)
    response = Net::HTTP.get_response(uri)
    if response.code != '200'
      raise "HTTP GET to #{uri.to_s} failed with error #{response.code}"
    end
    JSON.parse(response.body)
  end
end
