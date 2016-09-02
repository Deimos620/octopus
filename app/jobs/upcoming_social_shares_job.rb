class UpcomingSocialSharesJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(timeline)
    email_kind =  EmailKind.type_category_label("AdminEmailKind", "social-shares", "upcoming-#{timeline}")

    social_account_users = SocialAccountAuthorization.includes(:user).select(:user_id).uniq

    social_account_users.each do |saa|
      if timeline == "tomorrow"
        @upcoming = saa.user.managed_social_shares.scheduled_tomorrow
      elsif timeline == "this_week"
        @upcoming = saa.user.managed_social_shares.scheduled_this_week

      elsif timeline == "today"
       @upcoming = saa.user.managed_social_shares.scheduled_today
      end
      if @upcoming.present?
        puts "#{saa.user.name} has #{@upcoming.count} social shares #{timeline}"
        @upcoming.each do |social_share|
          puts "#{social_share.social_account.platform} #{social_share.copy.truncate(20)} #{social_share.scheduled_datetime.to_date.strftime("%D")} #{timeline}"

          if saa.user.on_email_list(email_kind.id)
            AdminMailer.warning(saa.user, email_kind, @upcoming)
            AddEmailLogJob.perform(saa.user, email_kind)
          end
        end
      else
        if timeline == "this_week"
          #suggest they add shares
          email_kind =  EmailKind.type_category_label("AdminEmailKind", "social-shares", "no-upcoming-this_week}")

          AdminMailer.warning(saa.user, email_kind, @upcoming)
        end
      end
    end  
  end 
end


