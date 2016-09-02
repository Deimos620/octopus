class BlogImage < ActiveRecord::Base
  mount_uploader :landscape_image, LandscapeUploader
  mount_uploader :portrait_image, PortraitUploader
  mount_uploader :thumbnail_image, ThumbnailUploader

  belongs_to :blog_post
  # has_many :blog_posts, through: :blog_selected_images
  has_many :blog_selected_images, dependent: :destroy

  STATUSES = [:sourced, :contacted, :rejected, :approved ]
  enum status: STATUSES

  LICENSES = [:unknown, :public_domain, :cc_attribution, :cc_ssa, :copyrighted ]
  enum license: LICENSES

end
