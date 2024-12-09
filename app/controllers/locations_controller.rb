class LocationsController < ApplicationController
  def search
    if params[:q].present?
      query = params[:q]
      @locations = Location.where("address ILIKE ?", "%#{query}%")
      render json: @locations.select(:id, :address)
    else
      render json: []
    end
  end
end
