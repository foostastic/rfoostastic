require 'test_helper'
require_dependency 'suso_refresh'

class SusoRefreshTest < ActiveSupport::TestCase

  test "happy case" do
    api = mock('SusoApi')
    api.expects(:players).returns(build_players)
    api.expects(:season).with("current").returns(build_api_seasons)
    api.expects(:classification).with("1").returns(build_api_classification)

    assert_equal(1, count_players_in_season)
    UserMailer.any_instance.expects(:update_valuation).once

    subject = SusoRefresh.new(api)
    subject.perform

    assert_equal(2, count_players_in_season)
  end

  private

  def count_players_in_season
    Player.where(division: "1").count
  end

  def build_players
    {
      "100" => {"name" => "one"}, # existing
      "101" => {"name" => "Paco"}, # new
    }
  end

  def build_api_seasons
    {
      "id" => "foos_one",
      "divisions" => [
        {"id" => "1", "level" => "1", "title" => "Division 1"}
      ]
    }
  end

  def build_api_classification
    [
      {"player_id" => "100", "points" => "50", "position" => "1"},
      {"player_id" => "101", "points" => "10", "position" => "2"},
    ]
  end

end
