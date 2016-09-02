class ProjectRsvpJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform
    email_type = "UserEmailKind"
    email_category = "organizers"
    email_label = "project-rsvp"
    email_kind =  EmailKind.type_category_label(email_type, email_category, email_label)

    last_email = EmailLog.where(email_kind_id: email_kind ).last
    # email_kind =  EmailKind.projecttype(event.project.category, "events", "response-#{response}")
    updated_after_date = Date.today - 1.day
    projects = Project.all
    participant_roles = ParticipantRole.firm_answers.updated_after(updated_after_date)

    projects.each do |project|
      @new_rsvps = participant_roles.where(project_id: project.id) unless participant_roles.blank?
      if @new_rsvps.present?
        project.project_organizers.each do |organizer|
        participant = project.participants.first #refactor
        ProjectMailer.project_rsvps(project,  email_kind, participant, updated_after_date.to_s).deliver_later
        puts "logged email #{project} #{email_kind.label}"

        email_recipient = organizer
        AddEmailLogJob.perform(email_recipient, email_kind)
      end

     end
    


   end
  end


end



      # new_rsvps = participant_roles.where("updated_at >= ?", Date.today) unless participant_roles.blank?
