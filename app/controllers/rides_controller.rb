class RidesController < ApplicationController
  before_action :authenticate_user!, only: [ :show ]
  before_action :find_ride, only: [ :show, :update_status ]
  def show; end

  def book
    # Retrieve source and destination locations from the form
    source_address = params[:source_location]
    destination_address = params[:destination_location]
    cab_category = params[:cab_category]

    # Find source and destination locations in the database
    source = Location.find_by(address: source_address)
    destination = Location.find_by(address: destination_address)

    if source.nil? || destination.nil?
      flash[:alert] = "Invalid source or destination. Please select from the dropdown."
      redirect_to root_path and return
    end

    # Ensure source and destination are different
    if source == destination
      flash[:alert] = "Source and destination cannot be the same."
      redirect_to root_path and return
    end

    # Find an available cab
    available_cab = Cab.where(is_available: true, category: cab_category).first
    if available_cab.nil?
      flash[:alert] = "No available cabs nearby. Please try again later."
      redirect_to root_path and return
    end

    # Create the ride
    ride = Ride.new(
      source_location: source,
      destination_location: destination,
      user: current_user,
      cab: available_cab,
      request_status: :booked,
      total_fare: 0 # Will be calculated on completion
    )

    if ride.save
      # Update the cab's availability
      available_cab.update(is_available: false)

      flash[:notice] = "Your ride has been booked successfully!"
      redirect_to ride_path(ride)
    else
      flash[:alert] = "Failed to book the ride. Please try again."
      redirect_to root_path
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
end
