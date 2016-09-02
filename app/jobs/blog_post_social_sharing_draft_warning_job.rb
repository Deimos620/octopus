class BlogPostSocialSharingDraftWarningJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
    social_shares =  BlogPostLive.scheduled_this_week.by_social_share_status("draft")
    social_shares.count
    email_kind = EmailKind.admin_emails.warnings("BlogPostSocialSharingDraftWarningJob")
    mailing_lists = EmailList.where(email_kind_id: email_kind.id) 

    notification_lists = AdminNotificationList.where(email_kind_id: email_kind.id) 

    notification_lists.each do |notification_list|
     AdminNotification.create!(kind: 8, user_id: notification_list.user.id, text: AdminNotification.kind_text(8, @social_shares.count))
    end

    mailing_lists.each do |mailing_list|
      AdminMailer.warning(mailing_list.user, @social_shares, email_kind.id ).deliver_later
    end
      
  end   
end



