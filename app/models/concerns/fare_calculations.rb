module FareCalculations
  extend ActiveSupport::Concern

  def calculate_distance
    Geocoder::Calculations.distance_between([ source_location.latitude, source_location.longitude ],
                                            [ destination_location.latitude, destination_location.longitude ]
                                            ).round(2)
  end

  def calculate_total_fare
    distance = calculate_distance
    rate_per_km = cab.regular? ? 12 : 18
    self.total_fare = (distance * rate_per_km).round(2)
  end
end
