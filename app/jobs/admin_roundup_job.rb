class AdminRoundupJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(timeline)
      label = "#{timeline}-roundup"
      # email_kind =  EmailKind.type_label("AdminEmailKind", " #{timeline}-roundup")
      email_kind =   EmailKind.type_category_label("AdminEmailKind", "roundups", label)

      last_of_this_email = EmailLog.where(email_kind_id: email_kind.id).last
      if last_of_this_email.present?
        since_date = last_of_this_email.created_at
      else
        since_date = Time.now - 10.days
      end
      mailing_lists = EmailList.where(email_kind_id: email_kind.id) 

      # recipient = User.find_by_email("emilypwing@gmail.com")
      mailing_lists.each do |mailing_list|
        AdminMailer.roundup(mailing_list.user, email_kind, since_date).deliver
        AddEmailLogJob.perform(mailing_list.user, email_kind)
      end
      

      #removeV1
        puts "logged email #{email_kind.type} #{email_kind.label}"
        puts "logged email #{email_kind.subject}  #{timeline}-roundup"
   

    end




  end


