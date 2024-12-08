class LocationsController < ApplicationController
  def search
    if params[:q].present?
      query = params[:q].downcase
      locations = Location.where("LOWER(name) LIKE :query OR LOWER(address) LIKE :query", query: "%#{query}%")
      render json: locations.select(:name, :address)
    else
      render json: []
    end
  end
end
