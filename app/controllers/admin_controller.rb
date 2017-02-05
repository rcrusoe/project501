class AdminController < ApplicationController
	before_action :is_admin?

    def unapproved_users
    	@users = User.order(updated_at: :desc)
    end

    def is_admin?
      # check if user is a admin
      # if not admin then redirect to where ever you want 
      redirect_to root_path unless current_user.admin? 
    end
end