class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  has_many :cabs, dependent: :destroy
  has_many :rides_from_source, class_name: "Ride", foreign_key: "source_location_id",  dependent: :destroy
  has_many :rides_from_destination, class_name: "Ride", foreign_key: "destination_location_id", dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
end
