class CabsController < ApplicationController
  before_action :authenticate_owner
  def index
    @cabs = Cab.all
  end

  private

  def authenticate_owner
    authenticate_user! && current_user.owner?
  end
end
