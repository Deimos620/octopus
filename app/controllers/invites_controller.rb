class InvitesController < DashboardController
  before_action :store_location
  before_action :authenticate_user!
  before_action :set_participant, except: [:index, :create, :resend_invite]
  before_action :verify_invite,  only: [:show, :rsvp]
  before_action :mark_seen, only: [:show]
  before_action :set_nested_project,  only: [:show, :rsvp, :resend_invite]
  before_action :set_current_user_participation,  only: [:resend_invite]


  [Project,  ParticipantRole, Role] if Rails.env == 'development'

  def index
    
  end

  def show
    @current_user_participation = current_user.current_project_participant(@participant.project_id)

  end

  def rsvp
    if params[:widget].present?
      redirectpath = redirect_to projects_path
    else
      redirectpath = redirect_to project_invite_path(project_id: @participant.project_id, id: @participant.id)
    end

    if @participant.update_attributes(editor_participant_id: @participant.id, status: params[:rsvp] )
      redirectpath
      else
      redirectpath
    end
  end

  def resend_invite
    @participant = Participant.find(params[:id])
    @participant_role = @participant.participant_roles.first || @participant_role = HelperParticipantRole.create!(participant_id: @participant.id)
    ProjectMailer.resend_invite(@participant, @participant_role, @project.kind).deliver_later
    @participant.update_attributes!(editor_participant_id: @current_user_participation.id, times_contacted: @participant.times_contacted + 1)
    if params[:source] && params[:source] == "index"
      redirect_to project_participants_path(project_id: params[:project_id])
    else
      redirect_to project_participant_path(id: params[:id], project_id: params[:project_id])
    end
  end

  # def update
  #   respond_to do |format|
  #     if @invite.update_attributes(editor_participant_id: @invite.id, status: params[:rsvp] )


  #       format.html { render :show }
  #       format.json { render :show, status: :ok, location: @invite }
  #     else
  #       format.html { render :show }
  #       format.json { render json: @invite.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def update
  #   rsvp = params[:rsvp]
  #   @invite = @participant
  #   respond_to do |format|
  #     if  @participant.update_attributes(editor_participant_id: @participant.id, status: params[:rsvp] )

  #       format.html { render :show }
  #       format.json { render :show, status: :ok, location: @invite }
  #     else
  #       format.html { render :show }
  #       format.json { render json: @invite.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private
  def set_participant
    @participant = Participant.find(params[:id])
  end

  def verify_invite
    if  current_user.email == @participant.email or current_user.id ==  @participant.user_id
    else
      redirect_to no_access_path
      NoAccessLog.create!(user_id: current_user.id , previous_page: request.fullpath)
    end

  end

  def set_nested_project
   @project = Project.find(params[:project_id]) ||  @project = Project.find(@invite.project_id) 
  end


  def mark_seen
    if @participant.unseen?
      @participant.status = "pending"
      @participant.save
    end
  end


  
end
