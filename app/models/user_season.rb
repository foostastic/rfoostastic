class UserSeason < ApplicationRecord
  audited
  belongs_to :user
  has_many :shares
  belongs_to :season

  def self.create_for_session_if_not_exists(user, season)
     UserSeason.find_or_create_by(user: user, season: season) do |u|
      u.credit = ENV["INIT_CREDIT"] || 300
    end
  end

  def get_total_value
    credit + shares_value
  end

  def get_value_on_last_change
    revision = self.audits.count - 1
    if revision > 0
      self.revision(revision).get_total_value
    else
      get_total_value
    end
  end

  def get_diff_value_on_last_change
    get_total_value - get_value_on_last_change
  end

  def on_player_value_update
    update_attributes(shares_value: calculate_shares_value)
  end

  def sell(share, amount)
    raise "Tried to sell shares you don't own... don't be a bad guy }:>" if share.amount - amount < 0

    profit = share.player.get_current_value * amount
    share.amount -= amount

    if share.amount == 0 then
      share.destroy
    else
      share.save
    end

    self.credit += profit
    self.shares_value = calculate_shares_value
    self.save
  end

  def buy(player, amount)
    cost = player.get_current_value * amount
    share = Share.new
    share.amount = amount
    share.buy_price = player.get_current_value
    share.player = player
    share.user_season = self
    share.save

    self.credit -= cost
    self.shares_value = calculate_shares_value
    self.save
  end

  private

  def calculate_shares_value
    value = 0
    shares.each do |share|
      value += share.get_current_value
    end
    value
  end

end
