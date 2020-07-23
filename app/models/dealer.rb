class Dealer < ApplicationRecord
  validates :salesforce_id, :name, :latitude, :longitude, presence: true
end
