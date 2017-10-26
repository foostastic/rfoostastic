class Share < ApplicationRecord
  belongs_to :player
  belongs_to :user_season

  def get_current_value
    player.get_current_value * amount
  end

  def get_total_buy_price
    buy_price * amount
  end

  def get_last_variation
    0
  end

  def self.get_sold_stocks_for_player(player)
    Share.where(player: player).sum(:amount)
  end

  def on_player_value_update
    user_season.on_player_value_update
  end

end
