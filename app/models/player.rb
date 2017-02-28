class Player < ApplicationRecord

  def get_current_value
    (points * get_ratio_for_division(division)) + get_offset_for_division(division)
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

end
