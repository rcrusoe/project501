class UsersController < ApplicationController

  before_filter :auth_user

  def auth_user
    unless user_signed_in?
      store_location_for(:user, request.fullpath)
      redirect_to new_user_registration_url
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
