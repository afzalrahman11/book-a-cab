# require 'faker'

# # Create an admin user
# User.create!(name: "Admin User", email: "admin@gmail.com", password: "admin123", phone: "9123456789", role: "admin")

# # Create records in locations table with the use of geocoder gem to fetch address and coordinates
# # from location name and viceversa.
# locations = [ "High Court Junction", "M.G. Road", "Ernakulam Junction South",
#   "Cochin International Airport", "Vyttila Mobility Hub", "Fort Kochi Beach",
#   "Kaloor Stadium", "Pallimukku", "Ernakulam North Railway Station",
#   "Cherai Beach", "Panampilly Nagar", "Rajagiri College", "Vyttila Junction",
#   "Elamkulam", "Seaport-Airport Road", "Thevara", "Aluva Market",
#   "Kochi Infopark", "Cusat Campus", "Angamaly", "Palarivattom Metro Station"
# ]

# locations.each do |location|
#   begin
#     geocode_location = Geocoder.search(location).first
#     if geocode_location.present?
#       latitude = geocode_location.coordinates.first
#       longitude = geocode_location.coordinates.second
#       unless Location.exists?(name: location)
#         Location.create!(name: location, address: geocode_location.address, latitude: latitude, longitude: longitude)
#       end
#     end
#   rescue StandardError => e
#     Rails.logger.error("Error fetching geocode for #{location}: #{e.message}")
#   end
# end

# # Create records in locations table using faker gem.
# # we can also use "KL07 #{("A".."Z").to_a.sample} rand(1000..9999)", but rare case it will create a duplicate number.
# location_ids = Location.pluck(:id)
# (0).upto 20 do
#   begin
#   Cab.create!(
#     model: Faker::Vehicle.make_and_model,
#     category: [ "regular", "premium" ].sample,
#     vehicle_number: "KL07 #{Faker::Alphanumeric.unique.alpha(number: 1).capitalize} #{rand(1000..9999)}",
#     location_id: location_ids.sample
#   )
#   rescue StandardError => e
#     Rails.logger.error("error: #{e.message}")
#   end
# end
