class AdminController < ApplicationController
	before_action :is_admin?

    def unapproved_users
    	@users = User.order(updated_at: :desc)
    end

    def users
        @users = User.order(updated_at: :desc)
    end

    def projects
    	@projects = Project.order(created_at: :desc)
    end

    def is_admin?
      redirect_to root_path unless current_user.admin?
    end
end
