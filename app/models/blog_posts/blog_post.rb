class BlogPost < ActiveRecord::Base
  extend FriendlyId
  include BasicScopes

  acts_as_taggable_on :blog_tags
  
  friendly_id :slug, use: :slugged

  mount_uploader :hero_img, HeroUploader
  mount_uploader :thumbnail_img, ThumbnailUploader


  has_many :blog_references
  # has_many :blog_images
  belongs_to :author, class_name: "BlogAuthor",  foreign_key: "blog_author_id"
  belongs_to :blog_editor, class_name: "User",  foreign_key: "blog_editor_user_id"
  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"
  belongs_to :section, class_name: "BlogSection",  foreign_key: "blog_section_id"
  has_many :meta_properties, class_name: "MetaProperty", foreign_type: "BlogPost", foreign_key: 'owner_id', dependent: :destroy

  has_many :tags, through: :blog_taggings
  has_many :blog_post_rankings, dependent: :destroy
  has_many :blog_images, through: :blog_selected_images
  has_many :blog_selected_images, dependent: :destroy
  has_many :blog_categories, through: :blog_post_categories
  has_many :blog_taggings, dependent: :destroy

  has_many :blog_tags, through: :blog_taggings

  has_many :blog_post_categories, dependent: :destroy


  STATUSES = [:idea, :draft, :pending, :accepted, :rejected, :scheduled, :pending_edit, :archived ]


  #Add new statuses to the end of the list. If you change this order of these than it will break the data.  
  enum status: STATUSES

  
   # --- VALIDATIONS ---
   validates :title, presence: {message: "Please enter a Title."}
   validates :slug, presence: {message: "Please enter a Slug."}
   validates :status, presence: true
   validates :slug, uniqueness: {message: "Oops! You've already used this slug! Try adding a number to the end."}

  scope :published_as_of, -> (date) do
    where('published_datetime <= ?',date)
  end 

  def self.types
    [
     BlogPostLive,
     BlogPostVersion
    ].flatten
  end
  def is_version?
    false
  end

  def is_live?
    if self.scheduled? && self.published_datetime <= Time.now
      true
    end
  end

  def is_queued?
    if self.scheduled? && self.published_datetime > Time.now
      true
    end
  end

  def permalink
    if blog_section_id
    "http://www.blog.ouroctopus.com/#{self.section.slug}/#{self.slug}"
    else
    "http://www.blog.ouroctopus.com/articles/#{self.slug}"
    end
  end

  def image
    if self.hero_img
      hero_img
    else
      "assets/images/default-hero.jpg"
    end
  end

  def meta_property_description
  end

  def meta_property_keywords
  end

  def posted_today?
    published_datetime == Date.today
  end

  def published_corrected
    if published_datetime && self.scheduled?
      published_datetime
    else
      Date.today + 1000.days
    end
  end

  # def popular_articles

  # end

  # def featured_articles

  # end

  # def newest_articles

  # end

  def waiting?
    true
  end

  def waiting_on
    waiting_images + " " +
    waiting_description  + " " +
    waiting_keywords  + " " +
    waiting_twitter
    # [waiting_images, waiting_description, waiting_keywords ]
  end

  def waiting_images
    if image.blank? 
      "images"
    end
  end

  def waiting_description
    if meta_property_description.blank? 
      "meta description"
    end
  end

  def waiting_keywords
    if meta_property_keywords.blank? 
      "keywords"
    end
  end

  def waiting_twitter
    if twitter_share.blank? 
      "twitter"
    end
  end

  def waiting_facebook
    if facebook_share.blank? 
      "facebook"
    end
  end

  def waiting_pinterest
    if pinterest_share.blank? 
      "pinterest"
    end
  end

  def waiting_references
    # if meta_property_keywords.blank? 
    #   "keywords"
    # end
  end

  def pinterest_share

  end

  def facebook_share

  end

  def twitter_share

  end
  before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.title.downcase.compact.join("-")
      end
    end
end
