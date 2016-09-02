class MetaProperty < ActiveRecord::Base
  belongs_to :page, class_name: "Page", foreign_type: "Page", foreign_key: 'owner_id'
  belongs_to :blog_post, class_name: "BlogPostOriginal", foreign_type: "BlogPostOriginal", foreign_key: 'owner_id'
  belongs_to :meta_property_category
  
   NAMES = [:unknown, :title, :description, :keywords, :unset_1, :unset_2, :og_title, :og_description, :og_site_name, :og_img,
              :og_type, :og_url, :twitter_card, :twitter_url, :twitter_title, :twitter_description, :twitter_image_src, 
              :twitter_site]


end
