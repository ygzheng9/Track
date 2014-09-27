class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    session[:client_id] = nil 

    @projects = Project.get_all_available
    @projects_closed = Project.get_all_closed
  end

  def index_nested
    session[:client_id] = params[:client_id]
    @client = Client.find(session[:client_id])    

    @projects = @client.projects.get_all_available
    @projects_closed = @client.projects.get_all_closed

    render "index"
  end 

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    if session[:client_id].nil? 
      @project = Project.new
    else
      @client = Client.find(session[:client_id])
      @project = @client.projects.new    
    end 
  end

  # GET /projects/1/edit
  def edit
    @client = Client.find(session[:client_id]) unless session[:client_id].nil?
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.is_available = 1

    respond_to do |format|
      if @project.save
        format.html { redirect_to list_target_url, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to list_target_url, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to list_target_url, notice: "Project was successfully deleted. " }
      format.json { head :no_content }
    end
  end

  # multiple checked to close
  def close_checked
    Project.mark_closed(params[:project_close_ids])

    redirect_to list_target_url, notice: "Project closed. "
  end 

  def reopen_checked
    Project.mark_reopen(params[:project_reopen_ids])

    redirect_to list_target_url, notice: "Project reopened. "
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
      # @project = Project.where(["id = ? ", params[:id]])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:client_id, :name, :code)
    end

    # based on session[:client_id]
    def list_target_url
      target_url = projects_path

      unless session[:client_id].nil?
        @client = Client.find(session[:client_id])
        target_url = client_projects_path(@client)
      end    

      return target_url   
    end       
end