class Blog::PagesController < ApplicationController


  before_action :store_location
  before_action :set_page, except: [:index]
  if !Rails.configuration.is_production_environment 
    before_action :authenticate_user! 
  end #remove launch 
  respond_to :html
  layout "blog"

  

  def index
    @pages = BlogPostStaticPage.all
  end

  def show
    
  end

  



 

  private

  def set_page
    @page = BlogPostStaticPage.friendly.find(params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
  
    # Never trust parameters from the scary internet, only allow the white list through.
  # def kind_params
   
    
  # end
end
