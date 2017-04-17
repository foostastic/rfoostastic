class Season < ApplicationRecord
  has_many :players
  validates :name, presence: true
  validates :foos_id, presence: true
end
