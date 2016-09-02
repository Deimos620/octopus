class EventResponseJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(event_id, response)
    event = Event.find(event_id)
    email_kind =  EmailKind.projecttype(event.project.category, "events", "response-#{response}")

    # @creator = Participant.find(@event.participant_id)
    # @project = Project.find(@creator.project_id)
    #sends to even scheduler
    
    ProjectMailer.event_response(event,  email_kind, response).deliver_later
    puts "logged email #{event.project.category} #{email_kind.label}"

    AddEmailLogJob.perform(event.participant, email_kind)

    #sends to recipients
    # @project.project_recipients.each do |p|
    #    ProjectMailer.event_response(event_id, p.id, @response, editor_user).deliver_later
    # end

  end


end



