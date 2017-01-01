class UserNotifierMailer < ApplicationMailer
  default :from => 'robinsongreig@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(author, receiver, conversation, topic, personal_message)
    @author = author
    @receiver = receiver
    @conversation = conversation
    @topic = topic
    @personal_message = personal_message
    mail( :to => @receiver.email,
    :subject => "New message from " + @author.name )
  end
end
