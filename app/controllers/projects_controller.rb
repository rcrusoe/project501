class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :submit_application]
  before_action :require_organization, only: [:new]
  skip_before_action :authenticate_user!, only: [:index, :show]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.order(created_at: :desc)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    if current_user
      @personal_message = current_user.personal_messages.build
    end
    @project = Project.friendly.find(params[:id])
    if request.path != project_path(@project)
      redirect_to @project, status: :moved_permanently
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/:project_name/applicants
  def applicants
    @project = Project.friendly.find(params[:project_name])
    @users = @project.applicants
    render :template => "projects/applicants"
  end

  # GET /projects/make-member/:id
  def make_member
    @project = Project.friendly.find(params[:project_id])
    Role.where(:project_id => params[:project_id], :user_id => params[:user_id]).update(:status => "Team Member")
    @users = @project.applicants 
    render :template => "projects/applicants"
  end

  # GET /projects/1/edit
  def edit
  end

  def close_project
    @project = Project.friendly.find(params[:id])
    @project.active = false
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'The project has successfully been closed.' }
        format.json { render :show, status: :created, location: @project }
        project_info = {
          pretext: "A project has been closed.",
          fallback: "#{@project.title}: #{@project.description}",
          title: "#{@project.title}",
          title_link: "#{project_url(@project)}",
          text: "#{@project.description}",
          color: "#BDD6DD",
        }
        PROJECT501_NOTIFIER.ping(attachments: [project_info])
      else
        format.html { redirect_to @project, notice: 'There was a problem closing this project.' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def open_project
    @project = Project.friendly.find(params[:id])
    @project.active = true
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'The project has successfully been re-opened.' }
        format.json { render :show, status: :created, location: @project }
        project_info = {
          pretext: "A project has been re-opened.",
          fallback: "#{@project.title}: #{@project.description}",
          title: "#{@project.title}",
          title_link: "#{project_url(@project)}",
          text: "#{@project.description}",
          color: "#BDD6DD",
        }
        PROJECT501_NOTIFIER.ping(attachments: [project_info])
      else
        format.html { redirect_to @project, notice: 'There was a problem re-opening this project.' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
        @project.roles.create(user_id: current_user.id, status: "Owner")
        project_info = {
          pretext: "A new #{@project.category} project has been created.",
          fallback: "#{@project.title}: #{@project.description}",
          title: "#{@project.title}",
          title_link: "#{project_url(@project)}",
          text: "#{@project.description}",
          color: "#BDD6DD",
        }
        PROJECT501_NOTIFIER.ping(attachments: [project_info])
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def submit_application
    @role = @project.roles.build(user_id: current_user.id, status: "Applicant")
    respond_to do |format|
      if @role.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description, :category, :deadline, :required_roles, :problem, :goal, :status)
    end

    def require_organization
      redirect_to new_organization_path unless current_user.organizations.exists?
    end
end
