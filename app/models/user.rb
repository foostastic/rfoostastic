class User < ApplicationRecord
  audited
  has_many :shares

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

  def self.find_or_create_from_auth_hash(auth_hash)
    user = User.find_by(username: auth_hash.uid)
    unless user
      user = User.new
      user.username = auth_hash.uid
      user.credit = 300
      user.save
    end
    user
  end

  def on_player_value_update
    update_attributes(shares_value: calculate_shares_value)
  end

  def sell(share, amount)
    profit = share.player.get_current_value * amount
    share.amount -= amount
    share.amount = 0 if share.amount < 0

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
    share.user = self
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
