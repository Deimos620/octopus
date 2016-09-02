class FeedbacksController < ApplicationController
  before_action :store_location
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_project_details

  def new

  end

  def create

  end

end
