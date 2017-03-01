class User < ApplicationRecord
  has_many :shares

  def get_total_value
    value = credit
    shares.each do |share|
      value += share.get_current_value
    end
    value
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

end
