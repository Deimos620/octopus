class Page < ActiveRecord::Base
  has_many :meta_properties, class_name: "MetaProperty", foreign_type: "Page", foreign_key: 'owner_id', dependent: :destroy

  belongs_to :section

  def permalink
    if section_id
      "http://www.ouroctopus.com/#{self.section.slug}/#{self.slug}"
    else
      "http://www.ouroctopus.com/info/#{self.slug}"
    end
  end

  before_save :set_slug, if: :new_record?
    
    def set_slug
      if self.slug.blank?
        self.slug = self.name.downcase
      end
    end
end
