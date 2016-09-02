class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :editor, class_name: "User", foreign_key: "editor_user_id"
end
