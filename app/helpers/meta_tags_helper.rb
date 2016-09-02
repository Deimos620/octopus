module MetaTagsHelper


#app meta
  def default_meta_title
    if @project
      @project.title
    elsif @page
      @page.title
    else
      "Octopus || Need 8 Hands?"
    end
  end

  def default_meta_url
    "http://www.ouroctopus.com"
  end

  def default_meta_description
    "Free party planning"
  end

  def default_meta_keywords
    "weddings, wedding planning"
  end

  def default_meta_image
    "http://www.ouroctopus.com/image.jpg"
  end


#blog meta
  def default_blog_meta_title
    if @article
      @article.title
    else
       "Pretty Handy || Octopus"
    end
  end

  def default_blog_meta_url
    "http://www.blog.ouroctopus.com"
  end

  def default_blog_meta_description
    "Crafts & planning blog"
  end

  def default_blog_meta_keywords
    "weddings, recipes, wedding planning, party blog, diy, crafts, "
  end

  def default_blog_meta_image
    "http://www.blog.ouroctopus.com/image.jpg"
  end

  def default_blog_meta_type
    if @article
      "article"
    else
    "website"
    end
  end

  def meta_tag_is_article?
    default_blog_meta_type == 'article'
  end

 

  #cleaning up controllers

  def blog_article_show_meta_tags
    section_title = @article.section.title if @article.section.present?
    author_name = @article.author.name if @article.author.present?
    image_url = @article.hero_img.url
     prepare_meta_tags(title: default_blog_meta_title,
                      description: @article.meta_property_description || default_blog_meta_description,
                      keywords: @article.meta_property_keywords  || default_blog_meta_keywords,
                      image: image_url || default_blog_meta_image,
                      type: "article",
                      article: {published_time:  @article.published_datetime || Date.today + 5.weeks, 
                                modified_time: @article.updated_at,
                                section: section_title || "articles",
                                author: author_name || "Octopus Staff",
                                # @article.tags.each do |tag|
                                #   tag:  tag.name 
                                # end

                                },
                      twitter: {card: "summary_large_image"},
                      og: {type: "article",},
                           # url: ""
                           # description: "d",
                           # keywords: "",
                      fb: {app_id: Rails.application.config.facebook_app_id}
                      )
                      
                          
  end

  def blog_article_index_meta_tags
     prepare_meta_tags(title: "Articles",
                      description: "Cool Articles" || default_blog_meta_description,
                      keywords: default_blog_meta_keywords,
                      image:  default_blog_meta_image,
                      twitter: {card: "summary_large_image"},
                      )
  end

  def blog_article_section_meta_tags
     prepare_meta_tags(title: @section.title || "Articles",
                      description: @section.description || default_blog_meta_description,
                      keywords: default_blog_meta_keywords,
                      image:  default_blog_meta_image,
                      twitter: {card: "summary_large_image"}
                      )
  end

  


end
