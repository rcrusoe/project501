class SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!
  before_filter :store_location
  before_filter :auth_user
end
