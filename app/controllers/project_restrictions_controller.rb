class ProjectRestrictionsController < DashboardController
  before_action :store_location
  before_action :set_project_restriction, only: [:show, :edit, :update, :destroy]

  # GET /project_restrictions
  # GET /project_restrictions.json
  def index
    @project_restrictions = ProjectRestriction.all
  end

  # GET /project_restrictions/1
  # GET /project_restrictions/1.json
  def show
  end

  # GET /project_restrictions/new
  def new
    @project_restriction = ProjectRestriction.new
  end

  # GET /project_restrictions/1/edit
  def edit
  end

  # POST /project_restrictions
  # POST /project_restrictions.json
  def create
    @project_restriction = ProjectRestriction.new(project_restriction_params)
    
    respond_to do |format|
      if @project_restriction.save
        format.html { redirect_to @project_restriction, notice: 'Project restriction was successfully created.' }
        format.json { render :show, status: :created, location: @project_restriction }
      else
        format.html { render :new }
        format.json { render json: @project_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /project_restrictions/1
  # PATCH/PUT /project_restrictions/1.json
  def update
    respond_to do |format|
      if @project_restriction.update(project_restriction_params)
        format.html { redirect_to @project_restriction, notice: 'Project restriction was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_restriction }
      else
        format.html { render :edit }
        format.json { render json: @project_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_restrictions/1
  # DELETE /project_restrictions/1.json
  def destroy
    @project_restriction.destroy
    respond_to do |format|
      format.html { redirect_to project_restrictions_url, notice: 'Project restriction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_restriction
      @project_restriction = ProjectRestriction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_restriction_params
      params[:project_restriction]
    end
end
