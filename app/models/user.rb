class User < ApplicationRecord
  has_many :shares

  def get_total_value
    value = credit
    shares.each do |share|
      value += share.get_current_value
    end
    value
  end

end
