class Section < ActiveRecord::Base
  has_many :pages
   before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.title.downcase
      end
    end
end
