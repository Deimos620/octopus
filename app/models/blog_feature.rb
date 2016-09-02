class BlogFeature < ActiveRecord::Base
    extend FriendlyId
    friendly_id :slug, use: :slugged

  before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.title.downcase
      end
    end
end
