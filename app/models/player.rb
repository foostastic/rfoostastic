class Player < ApplicationRecord
  has_many :shares

  after_update :on_player_update

  def get_current_value
    (points * get_ratio_for_division(division)) + get_offset_for_division(division)
  end

  def get_available_stocks
    max_stock = ENV["AVAILABLE_STOCK"] || 3
    max_stock - Share.get_sold_stocks_for_player(self)
  end

  private

  def get_ratio_for_division(division)
    values = {1 => 4, 2 => 2, 3 => 1}
    values[division]
  end

  def get_offset_for_division(division)
    values = {1 => 900, 2 => 300, 3 => 0}
    values[division]
  end

  def on_player_update
    shares.each { |share| share.on_player_value_update } if points_changed?
  end

end
