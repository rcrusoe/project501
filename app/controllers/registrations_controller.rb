class RegistrationsController < Devise::RegistrationsController
  after_action :send_welcome_message, only: :create

  def update
    super do
      #slack notification for updated users
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

  private

    def personal_message_params
      params.require(:personal_message).permit(:body)
    end

    def send_welcome_message
      @conversation = Conversation.create(author_id: 1,
                                          receiver_id: @user.id,
                                          project_id: 1)
      @personal_message = User.find_by_id(1).personal_messages.build(body: "Welcome to Project 501! Once you complete your volunteer profile, head over to the Projects page to find organizations you may be able to help. If you ever have any questions, you may contact the P501 team by replying here or emailing us at team@project501.com.")
      @personal_message.conversation_id = @conversation.id
      if @personal_message.save!
        # Deliver the notification email
        @topic = Project.find_by_id(@conversation.project_id)
        @message_author = User.find_by_id(1)
        @message_receiver = @user
        #currently confusing conversation receiver and message receiver, so short term hack to fix that
        UserNotifierMailer.send_message_email(@message_author, @message_receiver, @conversation, @topic, @personal_message).deliver
      end
    end

  protected

    def after_update_path_for(resource)
      user_path(resource)
    end
end
