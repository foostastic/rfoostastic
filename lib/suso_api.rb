require 'net/http'
require 'json'

class SusoApi

  def players
      get "/players"
  end

  def season(season_id)
      get "/seasons/#{season_id}"
  end

  def classification(division_id)
      get "/divisions/#{division_id}/classification"
  end

  private

  def get(uri)
    base_url = ENV["SUSO_FOOS_API_URL"] || "https://suso.eu/foos/api/v1"
    uri = URI(base_url + uri)
    response = Net::HTTP.get_response(uri)
    if response.code != '200'
      raise "HTTP GET to #{uri.to_s} failed with error #{response.code}"
    end
    JSON.parse(response.body)
  end

end
