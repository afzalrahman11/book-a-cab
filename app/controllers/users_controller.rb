class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show ]
  def index
    @users = User.where(role: :customer)
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
