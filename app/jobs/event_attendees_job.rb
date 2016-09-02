class EventAttendeesJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(event, job_action)
    project = Project.find(event.project_id)
    if job_action == "add"
        Attendee.create!(event_id: event.id, participant_id: event.participant_id, status: 3, invitor_participant_id: event.participant_id)
           email_kind =  EmailKind.projecttype_category_label(project.category, "events", "event-created")

        # email_kind = UserEmailKind.events.where(project_type: project.category).find_by_label("event-created")|| EmailKind.find(1)
        ProjectMailer.event_created(event, event.participant, email_kind).deliver_later
        puts "logged email #{project.category} #{email_kind.label} response-#{job_action}"
        puts "logged email #{email_kind.subject} "
        if project.is_meal_delivery?
          if  project.project_recipients.present?
            project.project_recipients.each do |recipient|
              Attendee.create!(event_id: event.id, participant_id: recipient.id,  invitor_participant_id: event.participant_id )
              # email_kind = UserEmailKind.events.where(project_type: project.category).find_by_label("add-attendee")|| EmailKind.find(1)
              email_kind =  EmailKind.projecttype_category_label(project.category, "events", "add-attendee")
              ProjectMailer.event_created(event, recipient, email_kind).deliver_later
            end
          end
          event.status = "pending"
          event.save
        else
          self.status = "pending"
          self.save
        end
    end

    #removeV1
        puts "logged email #{project.category} #{email_kind.label}"
        puts "logged email #{email_kind.subject} "

  end


end



