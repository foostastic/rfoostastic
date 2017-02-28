class Share < ApplicationRecord
  belongs_to :player
  belongs_to :user

  def get_current_value
    player.get_current_value * amount
  end

end
