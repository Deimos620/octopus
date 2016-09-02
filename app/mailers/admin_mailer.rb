class AdminMailer < ActionMailer::Base
  include ProjectsHelper
  include  EmailHelper

  # default from:  " MakeParty <team@makeparty.com>"
  default from:   "\"Octopus\"<team@ouroctopus.com>"
  default reply_to: "no-reply@ouroctopus.com"
    # default sent_on: Time.now
  layout 'mail'
  default content_type: 'text/html'
  default    sent_on: Time.now

          # AdminMailer.warning(saa.user, email_kind, @upcoming)

  def warning(recipient, email_kind, item_array )
      @recipient = recipient
      @email_kind = email_kind
      @item_array = item_array
      @ref = "admin"
      mail(to: @recipient.email, 
        subject: @email_kind.subject, 
        template_path: '/admin_mailers', 
        template_name: 
        'warning.html',
        )
     
    end

  def roundup(recipient, email_kind, date_since )
      @recipient = recipient
      @email_kind = email_kind
      @date_since = date_since
      @projects = Project.where("created_at >= ?", date_since)
      @users = User.where("created_at >= ?", date_since)
      @ref = "admin"
      mail(to: @recipient.email, 
        subject: @email_kind.subject, 
        template_path: '/admin_mailers', 
        template_name: 
        'roundup.html',
        )
     
    end

   

end

