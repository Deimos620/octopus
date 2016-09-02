class DashboardController < ApplicationController

  before_action :store_location
  before_action :authenticate_user!
  before_action :set_nested_project, only: [:index]
  # before_action :set_project_details, only: []
  before_action :set_current_user_participation, only: [:index]

  # before_action :authenticate_participation

  def index
    @project_dates = @project.project_dates.all.page params[:page]
  end

  # def lists

  # end

  

  def set_project_details
    # if @project.present?
    #      # @template = Template.find(@project.template_id)
    #      # @role = @project.participants.where(email: current_user.email).includes(:participant_cat).first
    #      # editing
    #      # @tasks = @project.tasks.includes(:task_assignee)
    #      # @milestones = @project.milestones.includes(:milestone_assignee)
    #      # @participants = Participant.where(project_id: @project.id).includes(:user)
    #      # @food = ProjectRestriction.where(project_id: @project.id)
    #      # @diet = ProjectRestriction.where(project_id: @project.id).diet
    #      # @allergy = ProjectRestriction.where(project_id: @project.id).allergy
    #      # @project_dates = Event.where(project_id: @project.id).order(occurs_on: :asc)
    #      # @project_tasks = current_user.tasks.where(project_id: @project.id).includes(:user).order(due_date: :asc)
    #      # @project_guests = @project.guests
    #      # @all_tasks = current_user.tasks.order(due: :asc)
    #      # @all_events = current_user.events.order(starts_on: :asc)
    #      # @upcoming_events = current_user.events.order(starts_on: :asc).upcoming
    #      # @projectschedule  = ProjectDate.where(project_id: @project.id).includes(events: :user).order(the_date: :asc)
    #      # @all_projects = Template.order(rank: :asc, id: :asc).active
    #      # @attendees = current_user.attendees
    #      # @user_participation =  current_user.participants.where(project_id: @project.id).first
    # end
  end

  private

  def set_current_user_participation
      @current_user_participation = current_user.current_project_participant(@project.id)
      if @current_user_participation.blank?
         @response = "denied"
      elsif  @current_user_participation.accepted?
        @response = "accepted"
      elsif   @current_user_participation.pending? or    @current_user_participation.unseen?
        @response = "unseen"
      elsif   @current_user_participation.declined?
        @response = "declined"
      else
        redirect_to no_access_path
      end
      user_participation_redirect(@response,  @current_user_participation)
   end



    def user_participation_redirect(response, current_user_participation)
      if response == "accepted"
       return
      elsif response == "denied"
       redirect_to no_access_path
       NoAccessLog.create!(user_id: current_user.id , previous_page: request.fullpath)
      elsif response == "unseen" or response == "declined" or response == "pending" or response == "maybe" 
       redirect_to project_invite_path(project_id: current_user_participation.project_id, id: current_user_participation.id)
       
      end
    end

    def verify_editor_privileges
      if current_user.can_edit(@project.id)
      else
         redirect_to no_access_path
         NoAccessLog.create!(user_id: current_user.id , previous_page: request.fullpath)
      end
    end
   
end
