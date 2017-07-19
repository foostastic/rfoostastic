class Player < ApplicationRecord
  audited
  has_many :shares
  belongs_to :season

  after_update :on_player_update

  def get_current_value
    if points > 0 then
      (points * get_ratio_for_division(division)) + get_offset_for_division(division)
    else
      0
    end
  end

  def get_available_stocks
    max_stock = ENV["AVAILABLE_STOCK"] || 3
    max_stock - Share.get_sold_stocks_for_player(self)
  end

  def can_be_bought
    return false if get_current_value == 0
    true
  end

  private

  def get_ratio_for_division(division)
    values = {1 => 4, 2 => 2, 3 => 1}
    values[division] || 0
  end

  def get_offset_for_division(division)
    values = {1 => 900, 2 => 300, 3 => 0}
    values[division] || 0
  end

  def on_player_update
    shares.each { |share| share.on_player_value_update } if points_changed?
  end

end
