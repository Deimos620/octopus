class HomeController < ApplicationController
  before_action :store_location
  if !Rails.configuration.is_production_environment
    before_action :authenticate_user! 
  end #remove launch 
  
  def index

  end

  def insides
    
  end

  def no_access

  end

  def contactus

  end

  def faq

  end

  def about

  end

  def advertise

  end

  def press

  end

  def privacypolicy

  end

  def terms

  end

  private
  def no_access_log_params
    params.require(:no_access_log).permit(:id, :user_id, :browser, :previous_page, :os, :platform )
  end

 
end
