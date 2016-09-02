class ParticipantsController < DashboardController
  include ProjectsHelper
  before_action :store_location
  before_action :authenticate_user!
  before_action :set_nested_project
  before_action :set_participant, except: [:new, :index, :create, :destroy, :invite_participants, :invite_recipients ]
  before_action :set_current_user_participation, only: [:new, :invite_participants, :index, :show]
  before_action :verify_editor_privileges, only: [:invite_participants, :new]
  [Project,  ParticipantRole, Role] if Rails.env == 'development'

  def index
    @participants = @project.participants
  end

  def new
    @participant = Participant.new(project_id: @project.id)
    @participant_role = params[:participant_role] || 4
    # @project.honored_guests.build
  end

  

  def invite_participants
      participant_role = params[:participant_role].to_i
      @message = params[:participant][:message]
      @participant_emails = params[:participant][:email].split(/,\s*/)
      @participant_emails.each do |participant_email|
        new_participant = Participant.new(email: participant_email, project_id: @project.id, 
                          editor_participant_id: @current_user_participation.id,  
                          invitor_participant_id: @current_user_participation.id, message: @message )
        if new_participant.save  
          participant_role = parsing_roles(participant_role)
          new_participant.create_participant_role(participant_role)
        end
          # self.response_body = nil
          set_to_active(@project)
          redirect_to project_participants_path(project_id: @project.id, w: 1)
     end
   end

   #  def invite_recipients
   #    participant_role = params[:participant_role].to_i
   #    @message = params[:message]
   #    @project.update!
   #    # @recipient = params[:project][:honored_guests][:email]
   #    @project.honored_guests.each do |honored_guest|
   #      new_participant = Participant.new(email: honored_guest.email, project_id: @project.id, 
   #        editor_participant_id: @current_user_participation.id,  invitor_participant_id: @current_user_participation.id, message: @message )
   #      if new_participant.save  
   #        participant_role = parsing_roles(participant_role)
   #        new_participant.create_participant_role(participant_role)
   #      end
   #        # self.response_body = nil
      
   #        set_to_active(@project)
   #        redirect_to project_participants_path(project_id: @project.id, w: 1)
   #   end
   # end
  
  private
  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
       params.require(:participant).permit(:id, :user_id, :project_id, :email, :message, :status, :editor_participant_id,
                                      :title, :connection_name, :connected_to, :relationship, :relationship_to_participant_id,  
                                      :relationship_to_name,  :relationship_to_title, :is_star,
                                      honored_guest_attributes: [:id, :project_id, :name, :participant_id, :participant_title_id, :passive]

                                      )
  end

  
end
