class Blog::ArticlesController < ApplicationController
  include MetaTagsHelper
  include BlogHelper

  before_action :store_location
  before_action :set_article, except: [:index]
  if !Rails.configuration.is_production_environment 
    before_action :authenticate_user! 
  end #remove launch 
  respond_to :html
  layout "blog"

  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "Pretty Handy"
    title       = default_blog_meta_title
    description = default_blog_meta_description
    image       = options[:image] || default_blog_meta_image
    current_url = request.url
    type = default_blog_meta_type
    # meta_url = default_blog_meta_url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[party diy wedding],
      twitter: {
        site_name: site_name,
        site: '@ouroctous',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: default_blog_meta_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: type 
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  def index
    @articles = BlogPostOriginal.all


  end

  def show
    blog_article_show_meta_tags
    gon.permalink = @article.permalink
    gon.article_id = @article.id

  end





 

  private

  def set_article
    @article = BlogPost.includes(:author).includes(:blog_categories).includes(:blog_tags).friendly.find(params[:id])
  end
    # Use callbacks to share common setup or constraints between actions.
  
    # Never trust parameters from the scary internet, only allow the white list through.
  # def kind_params
   
    
  # end
end
