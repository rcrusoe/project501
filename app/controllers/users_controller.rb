class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find(params[:id])
    @user = User.friendly.find(params[:id])
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
  end
end
