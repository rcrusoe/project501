class AdminController < ApplicationController
    def unapproved_users
        @users = User.all
    end
end
