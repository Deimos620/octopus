class BlogPostCategory < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :blog_category
end
