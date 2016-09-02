class Blog::SectionsController < ApplicationController
  include MetaTagsHelper
  include BlogHelper

  before_action :store_location
  before_action :set_section, except: [:index]
  if !Rails.configuration.is_production_environment 
    before_action :authenticate_user! 
  end #remove launch 
  respond_to :html
  layout "blog"

  

  def index
    @sections = BlogSection.all
  end

  def show
    # blog_section_show_meta_tags
    @articles = @section.blog_posts
  end

  



 

  private

  def set_section
    @section = BlogSection.friendly.find(params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
  
    # Never trust parameters from the scary internet, only allow the white list through.
  # def kind_params
   
    
  # end
end
