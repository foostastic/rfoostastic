require 'test_helper'

class UserSeasonTest < ActiveSupport::TestCase

  test "sell happy case" do
    user_season = user_seasons(:one)
    share = shares(:one)
    current_value = share.player.get_current_value
    current_credit = user_season.credit

    user_season.sell share, share.amount

    assert_equal user_season.credit, (current_value + current_credit).to_d
    assert_equal 0, share.amount
  end

  test "sell no more than available shares" do
    user_season = user_seasons(:one)
    share = shares(:one)
    current_credit = user_season.credit

    assert_raises RuntimeError do
      user_season.sell share, share.amount + 1
    end

    assert_equal current_credit, user_season.credit
  end

end
