class AdminController < ApplicationController
    def unapproved_users
        @users = User.all
        @personal_message = current_user.personal_messages.build
    end
end
