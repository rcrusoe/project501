class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.friendly.find(params[:id])
		if request.path != user_path(@user)
		  redirect_to @user, status: :moved_permanently
		end
	end

  	def approve_user
		@user = User.friendly.find(params[:id])
		@user.approved = true
		respond_to do |format|
		  if @user.save
		    format.html { redirect_to "/admin/unapproved_users", notice: 'The volunteer has successfully been approved.' }
		    format.json { render :show, status: :created, location: unapproved_users_admin_path }

		    @conversation = Conversation.where(receiver_id: @user.id, project_id: 1).first
			@personal_message = User.find_by_id(1).personal_messages.build(body: "Hey there - great to have you here! I have just approved your profile, so you should now be able to browse projects and reach out to organizations that you want to help. Cheers -- Robinson")
			@personal_message.conversation_id = @conversation.id
			if @personal_message.save!
				# Deliver the notification email
				@topic = "Your volunteer account has been approved!"
				@message_author = User.find_by_id(1)
				@message_receiver = @user
				#currently confusing conversation receiver and message receiver, so short term hack to fix that
				UserNotifierMailer.send_approval_email(@message_author, @message_receiver, @conversation, @topic, @personal_message).deliver
			end
		  else
		    format.html { redirect_to "/admin/unapproved_users", notice: 'There was a problem approving this volunteer.' }
		  end
		end
	end

end
