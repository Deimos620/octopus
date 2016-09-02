class EventsController < DashboardController
  before_action :set_nested_project, only: [ :approval_response]
  before_action :set_event, only: [:approval_response]
  before_action :set_current_user_participation, only: [:approval_response]
  before_action :store_location, only: []

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  def edit
  end

  

  def approval_response
    if params[:approval] == "false"
      @event.update_attributes(status: "reschedule", editor_participant_id: @current_user_participation.id)
      # BlockedTime.create!(time_start: @event.time_start, time_end: @event.time_end, project_date_id: @event.project_date_id)
      # EventResponseJob.perform_later(@event, @event.status)
      redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id), data: {no_turbolink: true} ,   notice: 'Appointment was approved.'
    elsif params[:approval] == "true"
      @event.update_attributes(status: "approved", editor_participant_id: @current_user_participation.id)
      # EventResponseJob.perform_later(@event, @event.status)
      redirect_to project_project_date_path(project_id: @event.project_id, id: @event.project_date_id), data: {no_turbolink: true} ,  notice: 'Appointment was approved.'
    else
    end
  end

  

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
       params.require(:event).permit(:id, :project_date_id, :project_id, :participant_id, :description, :status, :editor_participant_id,
                                      :date_start, :date_end, :all_day, :repeat, :time_start, :time_end, :category, :attendees_count, :address_id,
                                    attendees_attributes: [:id, :status, :participant_id]  )
    end
end
