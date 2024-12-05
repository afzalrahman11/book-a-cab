# Dummy data to create records in locations table with the use of geocoder gem to fetch address and coordinates
# from location name and viceversa.

locations = [ "Marine Drive", "Lulu Mall", "High Court Junction", "M.G. Road", "Ernakulam Junction South",
  "Cochin International Airport", "Vyttila Mobility Hub", "Fort Kochi Beach",
  "Kaloor Stadium", "Hill Palace Museum", "Pallimukku", "Ernakulam North Railway Station",
  "Cherai Beach", "Panampilly Nagar", "Rajagiri College", "Vyttila Junction",
  "Elamkulam", "Amrita Hospital", "Seaport-Airport Road", "Thevara", "Aluva Market",
  "Infopark Phase 2", "Cusat Campus", "Angamaly", "Palarivattom Metro Station"
]

locations.each do |location|
  begin
    geocode_location = Geocoder.search(location).first
    if geocode_location.present?
      latitude = geocode_location.coordinates.first
      longitude = geocode_location.coordinates.second
      unless Location.exists?(name: location)
        Location.create!(name: location, address: geocode_location.address, latitude: latitude, longitude: longitude)
      end
    end
  rescue StandardError => e
    Rails.logger.error("Error fetching geocode for #{location}: #{e.message}")
  end
end
