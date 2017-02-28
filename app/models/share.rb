class Share < ApplicationRecord
  belongs_to :player, :user
end
