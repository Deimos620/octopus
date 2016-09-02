class ProjectsController < DashboardController
  include ProjectsHelper

  before_action :store_location
  before_action :authenticate_user!
  before_action :set_project, only: [:destroy, :update, :show, :edit, :invite_recipients, :new, :update_date_range]
  before_action :set_nested_project, only: [:restrictions, :update_restrictions, :available_dates, :update_available_dates, :recipients,
    :edit_date_range, :update_date_range, :edit_date_range]
    before_action :set_project_details, except: [:new, :index, :create, :destroy, :update, :start]
    before_action :set_source, except: [:new, :index, :create, :available_dates]
    [Project,  ParticipantRole, Role] if Rails.env == 'development'
  # include ProjectsHelper
  before_action :set_current_user_participation,  except: [:new, :index, :create, :available_dates, :roles, :recipients, :kinds]

  # before_action :include_all_forms, only: [:meals_info, :meals_new_restrictions, :view_meals,  :meals_edit_info, :meals_edit_date_range, :new_party]
  # before_action :include_timepicker, only: [:meals_info, :meals_edit_info, :meals_edit_date_range, :new_party]
  layout 'application'
  respond_to :html

  def index
    @projects = @user_projects
  end

  def roles
    @project = Project.new(type: project_code_to_type(params[:project_type_code]))
    @project.participants.build
    @project.participant_roles.build
  end

  def new
    @project = Project.find(params[:id])
    @project.addresses.build
    @project.honored_guests.build
  end

  def edit
    @project.addresses.build
  end
  def create
    @project = Project.new(project_params)
    participant_role_type = params[:participant_role_type]
    if @project.save
      @project.create_organizer(participant_role_type, current_user)
      # @project.save
      # @project.create_organizer(participant_code_to_type(params[:participant_code]), current_user)
      redirect_to new_project_path(id: @project.id, ), data: {no_turbolink: true}
    else
      redirect_to root_path #refactor make error
    end
  end


  def update
    # date_formatter_helper(@project)
    puts " * " * 100
    @source = params[:source] || "show project" #refactor add option of redirecting to restrictions
    # date_formatter

    respond_to do |format|
      if @project.update(project_params)
        @project.edit_date_range_dates(@current_user_participation.id)
        successpath = setup(@source, @project)
        format.html { redirect_to successpath, data: {no_turbolink: true}}
        format.json { render  :show, status: :ok, location: @project   }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def restrictions
    @restrictions = Restriction.visible.all
  end

  def update_restrictions
    @source = "verify dates"
    @project.restriction_ids = params[:project][:restriction_ids]
    @project_restriction = ProjectRestriction.new

    if @project.update_attributes(project_params)
        # redirect_to  setup(@source, @project)
        redirect_to project_available_dates_path(project_id: @project.id, source: 'new'), data: {no_turbolink: true}
        flash[:notice] = "Successfully Added Food Allergies, Dietary Needs & Favorites."
      else
        redirect_to  project_add_restrictions_path(project_id: @project.id, source: 'new')
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end

    end

    def available_dates
    end

    def update_available_dates
      @project_dates = @project.project_dates.order(schedule_date: :asc)
    # logger.debug { "project_dates: #{params[:project_date_id]}" }
    if  @project_dates.where(id: params[:project_date_ids]).update_all(available: true) && @project_dates.where.not(id: params[:project_date_ids]).update_all(available: false)
      return   redirect_to  project_path(@project)
      flash[:notice] = "You've updated the available dates for #{@project.title}."
    else 
      # redirect_to  project_path(@project)
      redirect_to  project_available_dates_path(project_id: @project.id, source: 'new'), data: {no_turbolink: true}
      format.json { render json: @project.errors, status: :unprocessable_entity }
    end
  end

  def edit_date_range 
    if @project.has_prep_dates?
      @first_event = @project.events.order(date_start: :desc).first
      if @first_event.blank?
        gon.first_available_date = (@project.prep_start_datetime + 1.day)
      else
        gon.first_available_date =   @first_event.date_start.strftime("%m/%d/%Y ")
      end
      gon.prep_start =   @project.prep_start_datetime.strftime("%m/%d/%Y ")
      gon.prep_end =   @project.prep_end_datetime.strftime("%m/%d/%Y ")
    else
    end
  end

  def update_date_range

   respond_to do |format|
    if @project.update(project_params)
     @project.edit_date_range_dates(@current_user_participation.id)
     format.html { redirect_to project_available_dates_path(project_id: @project.id), data: {no_turbolink: true}}
     format.json { render  :show, status: :ok, location: @project   }
   else
    redirect_to  project_available_dates_path(project_id: @project.id), data: {no_turbolink: true}
    format.json { render json: @project.errors, status: :unprocessable_entity }
  end
end
end

def kinds

end

def recipients
  @participant_role = params[:participant_role] || 3
    @project.honored_guests.build
  end

  def invite_recipients
    participant_role = params[:participant_role].to_i
    @message = params[:message]
    @project.update(project_params)
    if   @project.save

        # @recipient = params[:project][:honored_guests][:email]
        @project.honored_guests.each do |honored_guest|
          if !honored_guest.passive?
            new_participant = Participant.new(email: honored_guest.email, project_id: @project.id, 
              editor_participant_id: @current_user_participation.id,  invitor_participant_id: @current_user_participation.id, message: @message )

            if new_participant.save
              honored_guest.participant_id = new_participant.id 
              honored_guest.save
              participant_role = "RecipientParticipantRole"
              new_participant.create_participant_role(participant_role)
              
            end
          end
            # self.response_body = nil
          end  
          set_to_active(@project)
          redirect_to project_participants_path(project_id: @project.id, w: 1)
        else
          redirect_to root_path
        end
      end




      private
      def set_project
        @project = Project.find(params[:id])
      end

      def set_source
        if params[:source].present?
          @source = params[:source]
        else
         @source = 'n'
       end
     end




    # Use callbacks to share common setup or constraints between actions.

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit( :type, :id, :organizer_participant_id, :status, :user_id, :description, :in_honor,
        :kind_id, :prep_start_datetime, :notes, :prep_end_datetime, :time_start, :time_end, :editor_participant_id, :max_visits, :long_description,
        participants_attributes: [:user_id, :project_id, :email, :status, :invitor_user_id, :editor_participant_id,
          participant_roles_attributes: [:id, :type, :participant_id]
          ],
          project_dates_attributes: [:id, :created_by, :project_id, :last_updated_by,   :available, 
            :appt_avail, :schedule_date, :events_count],
            addresses_attributes: [:id, :project_id, :title, :venue, :postal_code, :address_1, :address_2, :city, :us_state_id, :country_id, :website,
              :phone,  :primary],

              honored_guests_attributes: [:id, :project_id, :email,  :name, :participant_id, :participant_title_id, :passive]
              )
    end


  end
