class Profile < ActiveRecord::Base

  belongs_to :user
  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"
  has_many :profile_socials, dependent: :destroy
  has_many :feedbacks

  #nested
  accepts_nested_attributes_for :profile_socials
  accepts_nested_attributes_for :user

    # before_save :set_editor_user_id
  private

  # def set_editor_user_id
  #   if current_user.present?
  #     self.editor_user_id = current_user.id
  #   else
  #     self.editor_user_id = self.contact_id
  #   end
  # end

end
