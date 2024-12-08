class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :destroy ]
  def index
    @users = User.where(role: :customer)
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User deleted successfully."
    else
      flash[:alert] = "Failed to delete the user."
    end
    redirect_to users_path
  end
  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
