class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  after_action :send_welcome_message, only: :create

  skip_before_action :authenticate_user!
  before_filter :store_location
  before_filter :auth_user

  # GET /organizations
  # GET /organizations.json
  def index
    @organizations = Organization.all
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
    @organization = Organization.friendly.find(params[:id])
    @organization = Organization.friendly.find(params[:id])
    if request.path != organization_path(@organization)
      redirect_to @organization, status: :moved_permanently
    end
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to new_project_path, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
        @organization.memberships.create(user_id: current_user.id)
        organization_info = {
          pretext: "A new organization has been created.",
          fallback: "#{@organization.name}: #{@organization.description}",
          title: "#{@organization.name}",
          title_link: "#{organization_url(@organization)}",
          text: "#{@organization.description}",
          color: "#BDD6DD",
        }
        PROJECT501_NOTIFIER.ping(attachments: [organization_info])
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to @organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :website, :location, :description, :approved, :cause)
    end

    def personal_message_params
      params.require(:personal_message).permit(:body)
    end

    def send_welcome_message
      @user = User.find_by_id(Membership.where(organization_id: @organization.id).first.user_id)
      @conversation = Conversation.where(receiver_id: @user.id, project_id: 1).first
      @personal_message = User.find_by_id(1).personal_messages.build(body: "Your organization application has been received. Someone from our team will review your application in the next 24 hours. Once we approve your organization, you will be able to post a project to the community on behalf of your organization. Feel free to shoot over a reply if you have any questions.")
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
end
