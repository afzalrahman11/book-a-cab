class Cab < ApplicationRecord
  belongs_to :location
  has_many :rides, dependent: :destroy

  enum category: {
    regular: 0,
    premium: 1
  }
  validates :model, presence: true
  validates :vehicle_number, presence: true, uniqueness: true
  validates :category, presence: true
end
