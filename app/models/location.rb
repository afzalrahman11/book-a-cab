class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode
  has_many :cabs

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
end
