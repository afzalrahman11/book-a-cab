class CabsController < ApplicationController
  before_action :authenticate_admin
  before_action :find_cab, only: [ :edit, :update, :destroy ]
  def index
    @cabs = Cab.all
  end

  def new
    @cab = Cab.new
  end

  def create
    location = find_location
    return if location.nil?

    @cab = Cab.new(set_cab_params.merge(location_id: location.id))
    if @cab.save
      flash[:notice] = "Your cab has been registered successfully!"
      redirect_to cabs_path
    else
      flash[:alert] = "Failed to create the cab. Check the details entered."
      render :new
    end
  end

  def edit
  end

  def update
    location = find_location
    return if location.nil?

    if @cab.update(set_cab_params.merge(location_id: location.id))
      flash[:notice] = "Your cab details has been updated successfully!"
      redirect_to cabs_path
    else
      flash[:alert] = "Failed to update the cab. Check the details entered."
      render :edit
    end
  end

  def destroy
    if @cab.destroy
      flash[:notice] = "Cab deleted successfully."
    else
      flash[:alert] = "Failed to delete the cab."
    end
    redirect_to cabs_path
  end

  private

  def find_cab
    @cab = Cab.find(params[:id])
  end

  def authenticate_admin
    authenticate_user! && current_user.admin?
  end

  def set_cab_params
    params.require(:cab).permit(:model, :category, :vehicle_number, :location_id)
  end

  def find_location
    location = Location.find_by(address: params[:cab][:current_location])
    if location.nil?
      flash[:alert] = "Invalid location. Please select a valid location from the suggestions."
      render :new and return
    end
    location
  end
end
