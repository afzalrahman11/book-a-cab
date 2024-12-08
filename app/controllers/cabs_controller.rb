class CabsController < ApplicationController
  before_action :authenticate_admin
  def index
    @cabs = Cab.all
  end

  private

  def authenticate_admin
    authenticate_user! && current_user.admin?
  end
end
