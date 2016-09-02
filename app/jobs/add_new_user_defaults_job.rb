class AddNewUserDefaultsJob < ActiveJob::Base

  def self.perform(user)

    Profile.create!(user_id: user.id)
    user.originally_created_at = user.created_at
    user.created_at_ip = user.current_sign_in_ip
    user.save
    user_email_kinds = EmailKind.user_email 

    user_email_kinds.each do |ek|
      EmailList.create!(user_id: user.id, email_kind_id: ek.id)
    end

  end   
end



