class BlogCategory < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug, use: :slugged

    has_many :blog_post_categories, dependent: :destroy
    has_many :categorized_posts, through: :blog_post_categories

    validates :slug, presence: {message: "Please enter a Slug."}
    validates :slug, uniqueness: {message: "Oops! You've already used this slug! Try adding a number to the end."}
    validates :name, uniqueness: {message: "Oops! You've already used this name! Try adding a number to the end."}

    before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.name.downcase
      end
    end
end
