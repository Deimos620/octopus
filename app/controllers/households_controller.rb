class HouseholdsController < ApplicationController

  before_action :store_location
  before_action :authenticate_user!
  before_action :set_list, only: [:destroy, :update, :show, :edit]
  before_action :set_nested_project, only: []
  [Project,  ParticipantRole, Role, List] if Rails.env == 'development'
  before_action :set_current_user_participation,  only: []

  
  layout 'application'
  respond_to :html

  def split_households
    puts "updating #{params[:household_ids] }" * 1000

    # current_user.imported_households.update_all(["status", "approved"], ["id in (?)", params[:household_ids]])
    # current_user.imported_households.pending_split.where(:id => params[:household_ids]).update_all(:status => "approved", editor_user_id: current_user.id )
    approved_households = current_user.imported_households.pending_split.where(id: params[:household_ids])
    approved_households.each do |h|
      h.status = "approved"
      h.save
    end

    rejected_households = current_user.imported_households.pending_split
    rejected_households.each do |h|
      h.status = "rejected"
      h.save
    end
    # current_user.imported_households.pending_split.update_all(:status => "rejected", editor_user_id: current_user.id )
    redirect_to import_results_url(list_id: params[:list_id]), notice: "Contacts Split"

  end


  def join_households
    puts "updating #{params[:household_ids] }" * 1000
    # Household.update_all(["status", "approved"], ["id in (?)", params[:household_ids]])
    current_user.imported_households.pending_join.where( :id => params[:household_ids] ).update_all!(:status => "approved", editor_user_id: current_user.id )
    # current_user.imported_households.pending_join.update_all!(:status => "rejected", editor_user_id: current_user.id )
    redirect_to import_results_url(list_id: params[:list_id]), notice: "Contacts Split"
    
  end

  private

   def household_params
       params.require(:Household).permit(:id, :status )
    end



  
end
