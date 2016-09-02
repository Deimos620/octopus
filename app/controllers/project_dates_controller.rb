class ProjectDatesController < DashboardController
  before_action :store_location, only: [:show]
  before_action :authenticate_user!
  before_action :set_project_date, only: [ :edit, :update, :destroy, :add_event, :show]
  before_action :set_nested_project, only: [ :edit, :update, :destroy, :show, :add_event]
  
  before_action :set_current_user_participation, only: [:show, :new, :edit, :update, :destroy]

  include ProjectDatesHelper

  # GET /project_dates
  # GET /project_dates.json
  def index
    @project_dates = ProjectDate.all
  end

  # GET /project_dates/1
  # GET /project_dates/1.json
  def show
    @project_date.events.build
    @event = Event.new(project_id: @project.id, project_date_id: @project_date.id )
    @project_dates = @project.project_dates
    current_date = @project_dates.index(@project_date)
    @next = @project_dates[current_date + 1] if @project_dates.length >= current_date + 1
    @prev = @project_dates[current_date - 1] if current_date != 0
    @first = @project_dates.first if current_date != 0
    @last = @project_dates.last if current_date + 1 < @project_dates.length
    @current = current_date + 1
    if params[:event_id].present?
      @chosen_event = Event.find(params[:event_id])
    end

    gon.taken_times = taken_times(@project_date)
    
    # gon.unavailable_dates = unavailable_dates(@project_date)
    # gon.first_available_date =  @project.prep_start_datetime.strftime("%m/%d/%Y ")
    # gon.last_available_date =  @project.prep_end_datetime.strftime("%m/%d/%Y ")
    gon.time_start =  @project.time_start.strftime("%l:%M %P")
    gon.time_end =  @project.time_end.strftime("%l:%M %P")
  end


  # GET /project_dates/new
  def new
    @project_date = ProjectDate.new
  end

  # GET /project_dates/1/edit
  def edit
  end

  # POST /project_dates
  # POST /project_dates.json
  def add_event
    if @project_date.update_attributes(project_date_params)
      redirect_to project_project_date_path(project_id: @project.id, id: @project_date.id), data: {no_turbolink: true} 
      flash[:notice] ='Event was successfully created.'
    else
      redirect_to  project_project_date_path(project_id: @project.id, id: @project_date.id ), data: {no_turbolink: true} 
      format.json { render json: @project.errors, status: :unprocessable_entity }
      # redirect_to root_path, data: {no_turbolink: true} 
    end
  end



  # PATCH/PUT /project_dates/1
  # PATCH/PUT /project_dates/1.json
  # def update
  #   respond_to do |format|
  #     if @project_date.update(project_date_params)
  #       format.html { redirect_to @project_date, notice: 'Project date was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @project_date }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @project_date.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /project_dates/1
  # DELETE /project_dates/1.json
  def destroy
    @project_date.destroy
    respond_to do |format|
      format.html { redirect_to project_dates_url, notice: 'Project date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_date
      if params[:id]
        @project_date = ProjectDate.find(params[:id])
      else

        @project_date = ProjectDate.find(params[:project_date_id])
      end
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def project_date_params
       params.require(:project_date).permit(:id,  
          events_attributes: [:id, :project_date_id, :project_id, :participant_id, :description, :status, :editor_participant_id,
                                      :date_start, :date_end, :all_day, :repeat, :time_start, :time_end, :category, :attendees_count] )
    end

    
end
