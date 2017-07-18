require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "player cannot be bought when its value is zero" do
    player = Player.new
    player.points = 0
    assert !player.can_be_bought
  end

  test "player can be bought when its value is not zero" do
    player = Player.new
    player.points = 1
    player.division = 1
    assert player.can_be_bought
  end

  test "player default value is zero" do
    player = Player.new
    player.points = 0
    assert player.get_current_value == 0
  end
end
