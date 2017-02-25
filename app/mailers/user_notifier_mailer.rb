class UserNotifierMailer < ApplicationMailer
  default from: 'robinsongreig@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_message_email(author, receiver, conversation, topic, personal_message)
    @message_author = author
    @message_receiver = receiver
    @conversation = conversation
    @topic = topic
    @personal_message = personal_message
    @from =  "Tech Reserve <hi@techreserve.org>"
    mail(
      to: @message_receiver.email,
      subject: "New message from " + @message_author.name,
      from: @from
    )
  end

  def send_approval_email(author, receiver, conversation, topic, personal_message)
    @message_author = author
    @message_receiver = receiver
    @conversation = conversation
    @topic = topic
    @personal_message = personal_message
    @from =  "Tech Reserve <hi@techreserve.org>"
    mail(
      to: @message_receiver.email,
      subject: "New message from " + @message_author.name,
      from: @from
    )
  end

  def send_project_digest_email(user, projects)
    @recipient  = user
    @from =  "Tech Reserve <hi@techreserve.org>"
    @projects = projects
    mail(
      to: @recipient.email,
      subject: "[Tech Reserve] New opportunities to volunteer your skills",
      from: @from
    )
  end
end
