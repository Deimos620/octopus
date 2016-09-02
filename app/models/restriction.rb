class Restriction < ActiveRecord::Base
  has_many :project_restrictions, dependent: :destroy
  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"

  enum kind: [:unknown , :allergy, :diet, :other]

  scope :visible, -> { where(visible: true) }
  scope :allergy, -> { where(kind: 1) }
  scope :diet, -> { where(kind: 2) }

end
