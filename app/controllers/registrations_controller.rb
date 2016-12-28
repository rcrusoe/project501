class RegistrationsController < Devise::RegistrationsController

    skip_before_filter :authenticate_user!

protected

    def after_update_path_for(resource)
      user_path(resource)
    end

end
