class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :capture_referal
  before_action :set_layout, only: []
  before_action :store_location
  before_action :authenticate_user! , only: [:sidebar]
  # before_action :global
  before_action :sidebar
  # before_action :configure_permitted_parameters, if: :devise_controller?
  layout 'application'
  
  # 



  # def after_sign_in_path_for(resource)
  #   sign_in_url = new_user_session_url
  #   if request.referer == sign_in_url
  #     super
  #   else
  #     stored_location_for(resource) || request.referer || root_path
  #   end
  # end

  def after_sign_in_path_for(resource)
    # if request.referer == sign_in_url
    #   super
    # else
 stored_location_for(resource) || request.referer || projects_path
      # session[:previous_url] || projects_path
    # end
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited. Devise...
    # return unless request.get? 
    # if (request.path != "/auth/sign_in" &&
    #   request.path != "/auth/sign_up" &&
    #   request.path != "/auth/password/new" &&
    #   request.path != "/auth/password/edit" &&
    #   request.path != "/auth/confirmation" &&
    #   request.path != "/auth/sign_out" &&
    #   request.path != "/auth/registrations/new" &&
    #     !request.xhr?) # don't store ajax calls
    #   session[:previous_url] = request.fullpath 
    # end
  end



  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def sidebar
    if signed_in?
      # current_user.invites
      # current_user.projects_participating
      # current_user.all_projects
      # @newInvites = Participant.includes(:project).where(email: current_user.email).where(status: 'unseen')
      # @user_projects = current_user.participants.accepted.joins(:project).distinct.order(created_at: :asc)
      # @all_projects = Project.types
    else
    end
  end




  def global 
    # @header = false
    # @show_header = params[:y]
    # @testing = true
    # @show_ads = false
    # @show_twitter = false
  end 

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  

  def set_nested_project
    @project || @project = Project.find(params[:project_id])
  end



  protected


  # def configure_permitted_parameters
    
  #   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:id, :first_name, :last_name, :email, :gender, :avatar, :birth_date,
  #     :password, :password_confirmation, :accept_terms, :level, :provider, :uid, :editor_user_id, :locale, :location, :oauth_expires_at, :oauth_token) }
  #   devise_parameter_sanitizer.for(:account_update){ |u| u.permit(:first_name, :last_name, :email, :gender, :avatar, :level, :role,
  #        :password, :password_confirmation, :current_password, :oauth_expires_at, :oauth_token,
  #                 )}
  #   # devise_parameter_sanitizer.permit(:sign_up) do |user_params|
  #   #     user_params.permit(:id, :first_name, :last_name, :email, :gender, :avatar,
  #   #   :password, :password_confirmation, :accept_terms, :level, :provider, :uid, :editor_user_id, :oauth_expires_at, :oauth_token,)
  #   #   end

  #   # devise_parameter_sanitizer.permit(:sign_in) do |user_params|
  #   #   user_params.permit(:username, :email)
  #   # end
  # end

  def capture_referal
    session[:referral] = params[:ref] if params[:ref]
  end
end
