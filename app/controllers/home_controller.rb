class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @projects = Project.order(created_at: :desc)
  end
end
