class EmailLog < ActiveRecord::Base
  belongs_to :participant, class_name: 'Participant', foreign_key: 'receiver_participant_id'
  belongs_to :user, class_name: 'User', foreign_key: 'sender_user_id'
  belongs_to :email_kind


  scope :by_email_kind_category, lambda { |category|
    joins(:email_kind).where(email_kinds: { category: category })
  }
end


