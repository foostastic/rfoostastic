class User < ApplicationRecord
  has_many :user_seasons

  def self.find_or_create_from_auth_hash(auth_hash)
    social_id = "#{auth_hash.provider}:#{auth_hash.uid}"
    user = User.find_or_initialize_by(social_id: social_id)
    user.name = auth_hash.info.name
    user.email = auth_hash.info.email
    user.image = auth_hash.info.image
    user.save
    user
  end

end
