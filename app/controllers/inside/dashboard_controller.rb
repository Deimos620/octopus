class Inside::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_inside_privileges
  before_action :store_location
  layout 'inside'

  def index
    # @appointment_link = project_project_date_path(id: date.id, project_id: date.project_id)
  end

  private
  def authenticate_inside_privileges
    if !current_user.has_inside_privileges?
      initiate_no_access
    end
  end

  def initiate_no_access
    redirect_to no_access_path
    NoAccessLog.create!(user_id: current_user.id , previous_page: request.fullpath)
  end

end
