class BlogAuthor < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug, use: :slugged

  has_many :blog_posts
  belongs_to :user

  before_save { self.first_name = first_name.capitalize if self.first_name? }
  before_save { self.last_name = last_name.capitalize  if self.last_name?}

  validates :slug, uniqueness: {message: "Oops! You've already used this first name! Try adding a dash and a last name."}

  def name
    if self.first_name.present?
      first_name + " " + last_name rescue first_name + "" rescue "" + last_name rescue "BlogAuthor"
    else
      self.user.name
    end
  end

    before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.name.downcase
      end
    end
end
