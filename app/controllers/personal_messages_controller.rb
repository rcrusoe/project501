class PersonalMessagesController < ApplicationController
  before_action :find_project!
  before_action :find_conversation!


  def new
    @personal_message = current_user.personal_messages.build
  end

  def create
    @conversation ||= Conversation.create(author_id: current_user.id,
                                        receiver_id: @receiver.id, project_id: @project.id)
    @personal_message = current_user.personal_messages.build(personal_message_params)
    @personal_message.conversation_id = @conversation.id
    if @personal_message.save!
      # Deliver the notification email
      UserNotifierMailer.send_signup_email(@receiver).deliver
    end

    if @project
      redirect_to apply_project_path(@project)
    else
      redirect_to conversation_path(@conversation)
    end
    flash[:success] = "Your message was sent!"
  end

  private

  def personal_message_params
    params.require(:personal_message).permit(:body)
  end

  def find_project!
    if params[:project_id]
      @project = Project.find_by(id: params[:project_id])
      redirect_to(projects_path) and return unless @project
    end
  end

  def find_conversation!
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
      redirect_to(conversations_path) and return unless @receiver
    else
      @conversation = Conversation.find_by(id: params[:conversation_id])
      @receiver = User.find_by_id(@conversation.receiver_id)
      redirect_to(conversations_path) and return unless @conversation && @conversation.participates?(current_user)
    end
  end
end
