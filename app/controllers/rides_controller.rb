class RidesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  before_action :find_ride, only: [ :show, :update_status ]
  def show; end

  def book
    # Find source and destination locations from the user inputs
    source_location, destination_location = find_location(params[:source_location], params[:destination_location])

    # Ensure source or destination is present and different
    if source_location.nil? || destination_location.nil?
      handle_redirect("Invalid source or destination. Please select from the dropdown.")
    elsif source_location == destination_location
      handle_redirect("Source and destination cannot be the same.")
    end

    # Find an available cab
    nearest_cab = find_nearest_cab(source_location, params[:cab_category])
    if nearest_cab.nil?
      handle_redirect("No available cabs nearby. Please try again later.")
    else
      # Create the ride
      ride = create_ride(source_location, destination_location, nearest_cab)

      if ride.save
        # Update the cab's availability
        nearest_cab.update(is_available: false)

        flash[:notice] = "Your ride has been booked successfully!"
        redirect_to ride_path(ride)
      else
        handle_redirect("Failed to book the ride. Please try again.")
      end
    end
  end

  def update_status
    if @ride.update(request_status: :completed)
      @ride.calculate_total_fare
      @ride.save!

      # Update the cab's availability and location
      @ride.cab.update(
        is_available: true,
        location: @ride.destination_location
      )

      flash[:notice] = "Ride marked as completed."
      redirect_to ride_path(@ride) # Redirect to show ride details
    else
      flash[:alert] = "Failed to mark the ride as completed."
      redirect_to ride_path(@ride)
    end
  end

  private

  def find_ride
    @ride = Ride.find(params[:id])
  end

  def handle_redirect(message, path = root_path)
    flash[:alert] = message
    redirect_to path and return
  end

  def find_location(source_address, destination_address)
    source_location = Location.find_by(address: source_address)
    destination_location = Location.find_by(address: destination_address)
    if source_location.nil? || destination_location.nil? || source_location == destination_location
      return nil, nil
    end

    [ source_location, destination_location ]
  end

  def find_nearest_cab(source_location, cab_category)
    cabs_available = Cab.where(is_available: true, category: cab_category)

    nearest_cab = cabs_available.min_by { |cab| calculate_distance(source_location, cab.location) }
    nearest_cab
  end

  def create_ride(source_location, destination_location, nearest_cab)
    Ride.new(
      source_location: source_location,
      destination_location: destination_location,
      user: current_user,
      cab: nearest_cab,
      request_status: :booked,
      total_fare: 0 # Will be calculated on completion
    )
  end
  def calculate_distance(source, destination)
    Geocoder::Calculations.distance_between([ source.latitude, source.longitude ],
                                            [ destination.latitude, destination.longitude ]
                                            ).round(2)
  end
end
