class Ride < ApplicationRecord
  include FareCalculations

  belongs_to :source_location, class_name: "Location", foreign_key: "source_location_id"
  belongs_to :destination_location, class_name: "Location", foreign_key: "destination_location_id"
  belongs_to :user
  belongs_to :cab

  enum request_status: {
    booked: 0,
    completed: 1
  }

  # validates :source_location_id - only check if that column has a value but dont check if the referenced object
  # (ie, location) exists or is valid.
  validates :source_location, presence: true
  validates :destination_location, presence: true
  validates :total_fare, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :user, presence: true
  validates :cab, presence: true

  # custom validation not to allow same source and destination
  validate :source_and_destination_must_be_different

  def source_and_destination_must_be_different
    if source_location_id == destination_location_id
      errors.add(:destination_location, "must be different from source!")
    end
  end
end
