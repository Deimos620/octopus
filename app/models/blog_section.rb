class BlogSection < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug, use: :slugged

  has_many :blog_post_originals, class_name: "BlogPostOriginal",  foreign_key: "blog_section_id"
  has_many :blog_posts, class_name: "BlogPost",  foreign_key: "blog_section_id"



  def newest_image
    self.blog_posts.where(type: 'BlogPostOriginal', blog_section_id: self.id).last.image unless self.blog_posts.blank?
  end

  def has_published_articles?
    BlogPostOriginal.scheduled.published_as_of(Time.now).where(blog_section_id: self.id).present?
  end

   before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.title.downcase
      end
    end
    
end
