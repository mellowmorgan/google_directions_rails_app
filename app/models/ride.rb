class Ride < ApplicationRecord
  validates :start_address, presence: true
  validates :end_address, presence: true
end
