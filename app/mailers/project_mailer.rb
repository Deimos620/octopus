class ProjectMailer < ActionMailer::Base
  include ProjectsHelper
  include  EmailHelper

  # default from:  " MakeParty <team@makeparty.com>"
  default from:   "\"Octopus\"<team@ouroctopus.com>"
  default reply_to: "no-reply@ouroctopus.com"
    # default sent_on: Time.now
  layout 'mail'
  default content_type: 'text/html'
  default    sent_on: Time.now


    def invite(participant_role, email_kind)
      @email_kind = email_kind
      @participant_role = participant_role
      @project = Project.find(@participant_role.participant.project_id)
      # crypt = ActiveSupport::MessageEncryptor.new(Rails.configuration.linkref_secret_key_base)
      # ref = crypt.encrypt_and_sign("participant_id = ")
      @ref = "Edo"
      # @ref = ReferralCategory.get_category(email_kind, @participant_role.grantor.user)
      mail(to: @participant_role.participant.email, 
        subject: @email_kind.subject, 
        template_path: '/project_mailers', 
        template_name: 
        'add_participant.html',
        )
    end

    def project_rsvps(project,  email_kind, participant, updated_after_date)
      @project = project
      updated_after_date = updated_after_date.to_date
      @participant = participant
      @participant_roles = ParticipantRole.firm_answers.updated_after(updated_after_date)
      @new_rsvps = @participant_roles.where(project_id: @project.id) 
      @email_kind = email_kind
      @ref = "Edo"
        mail(to: @participant.user.email, 
        subject: @email_kind.subject, 
        template_path: '/project_mailers', 
        template_name: 
        'project_rsvps.html',
        )
    end

    def event_created(event, recipient, email_kind)
      @email_kind = email_kind
      @event = event
      @recipient = recipient
      @ref = "Edo"
        mail(to: @recipient.email, 
        subject: @email_kind.subject, 
        template_path: '/project_mailers', 
        template_name: 
        'event_created.html',
        )
    end

    def event_response(event, email_kind, response)
      @event = event
      @email_kind = email_kind
      @ref = "Edo"
        mail(to: @event.participant.user.email, 
        subject: @email_kind.subject, 
        template_path: '/project_mailers', 
        template_name: 
        'event_response.html',
        )
    end


    def project_created(project, organizer, email_kind)
      @email_kind = email_kind
      @project = project
      @recipient = organizer
      @ref = "Edo"
        mail(to: @recipient.email, 
        subject: @email_kind.subject, 
        template_path: '/project_mailers', 
        template_name: 
        'project_created.html',
        )
    end

    
#     def project_confirmation(project, current_user)
#       @referral = 11
#       @project = project
#       @template = Template.find(@project.template_id)

#       @user = current_user
#       @email = @user.email

#       mailer_name = "PROJECT_CONFIRMATION"
#       mail(to: @email, 
#         subject: 'Octopus Project Created',  
#         template_path: '/project_mailers', 
#         template_name: 
#         'project_confirmation.html',
#         )
#     end

#     def project_incomplete

#     end

#     def project_approval(project, user, organizer, template)
#       @referral = 4
#       @project = project
#       @template = template
#       @user = user
#       @organizer = organizer
#       @email = @organizer.email
#       mailer_name = "PROJECT_APPROVAL"
#       mail(to: @email, 
#         subject: 'Project Approved',  
#         template_path: '/project_mailers', 
#         template_name: 
#         'project_approval.html',
#         )

#     end

#   # def send_newsletter_to_subscribers(subscribers, newsletter)
#   #   subscribers.each do |subscriber|
#   #     @email = subscriber.email
#   #     @newsletter = newsletter
#   #     mail(to: @email, subject: newsletter.subject, template_name: 'newsletter').deliver
#   #   end
#   # end



#   def notify_recipient(newpart, project,  added_by,  participant_invite)
#  #@message = participant_invite[:message]
#  # @mssge = mssge
#  @referral = 2
#  @project = project
#  @template = Template.find(@project.template_id)
#  @participant = newpart
#  @recipient = newpart.email
#  @withname = User.where(email: @participant.email)
#  @added_by = added_by
#  @diet = ProjectRestriction.where(project_id: @project.id).diet
#  @allergy = ProjectRestriction.where(project_id: @project.id).allergy
#  @addresses = Address.where(project_id: @project.id) 
#  mailer_name = "NOTIFY_RECIPIENT"
#  @email = @participant.email
#  mail(to: @email, 
#   subject: 'You are getting Meal Deliveries',  
#   template_path: '/project_mailers', 
#   template_name: 
#   'notify_recipient.html',
#   )
# end

# def notify_participant_meals(newpart, project, current_user,  participant_invite)
# # @mssge = mssge
# @project = project
# @referral = 6
# @template = Template.find(@project.template_id)
# @participant = newpart
# @recipient = newpart.email
# @withname = User.where(id: @participant.user_id)
# @user = current_user
# @email = @recipient
# mailer_name = "NOTIFY_PARTICIPANT_MEALS"
# mail(to: @email, 
#   subject: 'You\'ve been has invited to an Octopus Project',  
#   template_path: '/project_mailers', 
#   template_name: 
#   'notify_participant_meals.html',
#   )
# end

# def add_participant( project, current_user, participant, subject)
# # @mssge = mssge
# @subject = subject
# @project = project
# @referral = 7
# @template = Template.find(@project.template_id)
# @participant = participant
# @recipient = participant.email
# @user = current_user
# @email = @participant.email
# mailer_name = "ADD_PARTICIPANT"
# mail(to: @email, 
#   subject: @subject, 
#   template_path: '/project_mailers', 
#   template_name: 
#   'add_participant.html',
#   )
# end

# # def project_deletion(template, current_user, in_honor, caveat_8, participants, message)
# #   @template = template
# #   current_user = current_user

# #   @in_honor = in_honor
# #   @caveat_8 = caveat_8
# #   mailer_name = "PROJECT_DELETION"
# #   participants.each do |participant|
# #    @user = User.find(21)

# #    @participant_user = User.find(participant.user_id)
# #    @email = participant.email
# #    mail(to: @email, 
# #     subject: 'Project Deleted',   
# #     template_path: '/project_mailers', 
# #     template_name: 'project_deletion.html')
# #  end
# # end

# def project_deletion(current_user, template, participant, in_honor, caveat_8, message)
#   @user = current_user
#   @participant = participant
#   @template = template
#   @in_honor = in_honor
#   @caveat_8 = caveat_8
#   @message = message
#   @referral = 8

#   if @participant.user_id?
#    @participant_user = User.find(participant.user_id)
# end
#   mailer_name = "PROJECT_DELETION"
#    @email = @participant.email
#    mail(to: @email, 
#     subject: 'Project Cancelled',   
#     template_path: '/project_mailers', 
#     template_name: 'project_deletion.html')
# end

# def event_approved(event, project, current_user,  scheduler)
#   @user = current_user
#   @project = project  
#   @event = event
#   @scheduler = scheduler

#   @email = @scheduler.email
#   @referral = 5
#   mailer_name = "EVENT_APPROVED"
#   mail(to: @email, 
#     subject: 'Appointment Approved!',  
#     template_path: '/project_mailers', 
#     template_name: 
#     'event_approved.html',
#     )
# end

# def event_reschedule_notify(event_reschedule, current_user, user)
#   @event_reschedule = event_reschedule
#   @event = Event.find(@event_reschedule.event_id)
#   # @scheduler = User.find(@event.user_id)
#   @scheduler = user
#   @recipient = current_user
#   @project = Project.find(@event.project_id)  
#   @email = @scheduler.email
#   if @event_reschedule.change_time = true
#  @subject =' Appointment Time Unavailable, Please Reschedule'
#   end
#     if @event_reschedule.change_date = true
#  @subject =' Appointment Date Unavailable, Please Reschedule'
#   end
#   @referral = 12
#   mailer_name = "EVENT_RESCHEDULE_NOTIFY"
#   mail(to: @email, 
#     subject: @subject,
#     template_path: '/project_mailers', 
#     template_name: 
#     'event_reschedule_notify.html',
#     )
# end

# def new_appointment_confirmation(event, current_user)
#   @user = current_user
#   @event = event  
#   @project = Project.find(@event.project_id)
#   @email = @user.email
#   @referral = 17
#   mailer_name = "NEW_APPOINTMENT_CONFIRMATION"
#   mail(to: @email, 
#     subject: 'You Created an Octopus Appointment!',  
#     template_path: '/project_mailers', 
#     template_name: 
#     'new_appointment_confirmation.html',
#     )
# end

# def reschedule_appt_confirmation(event, current_user)
#   @user = current_user
#   @event = event  
#   @project = Project.find(@event.project_id)
#   @email = @user.email
#   @referral = 19
#   mailer_name = "RESCHEDULE_APPT_CONFIRMATION"
#   mail(to: @email, 
#     subject: 'You Rescheduled an Octopus Appointment!',  
#     template_path: '/project_mailers', 
#     template_name: 
#     'reschedule_appt_confirmation.html',
#     )
# end

# def rsvp_reminder

# end

end

