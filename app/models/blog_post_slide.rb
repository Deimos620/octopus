class BlogPostSlide < ActiveRecord::Base
  belongs_to :blog_post
  belongs_to :blog_image

  STATUSES = [:portrait, :landscape]
  enum orientation: STATUSES
end
