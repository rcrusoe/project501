class RegistrationsController < Devise::RegistrationsController

  def update
    super do
      if @user.save
        user_info = {
          pretext: "A user has updated their account.",
          fallback: "#{@user.name}: #{@user.tagline}",
          title: "#{@user.name}",
          title_link: "#{project_url(@user)}",
          text: "#{@user.tagline}",
          color: "#BDD6DD",
        }
        PROJECT501_NOTIFIER.ping(attachments: [user_info])
      end
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
