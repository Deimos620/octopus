class AddEmailLogJob < ActiveJob::Base

  def self.perform(email_recipient, email_kind)
     EmailLog.create!(email_kind_id: email_kind.id, receiver_participant_id: email_recipient.id)
  end   
end



