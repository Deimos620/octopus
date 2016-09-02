class ContactsController < ApplicationController

  before_action :store_location
  before_action :authenticate_user!
  before_action :set_list, only: [:destroy, :update, :show, :edit]
  before_action :set_nested_project, only: []
  [Project,  ParticipantRole, Role, List] if Rails.env == 'development'
  before_action :set_current_user_participation,  only: []

  
  layout 'application'
  respond_to :html

  def index
    @contacts = current_user.imported_contacts.includes(:address).includes(:household).includes(:guests)


  end

  def import_results
    @list = List.find(params[:list_id]) unless params[:list_id].blank?
    
  end
end
