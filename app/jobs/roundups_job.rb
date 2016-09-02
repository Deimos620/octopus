class RoundupJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(timeline)
        participants_in_active_projects = Participant.joins(:project).where(project: {status: "active"})
        participants_in_active_projects.each do |participant|
        events = Attendees.includes(:event).where(participant_id: participant.id).accepted.by_timeline(timeline)
          if participant.project.is_meal_delivery?
            if participant.is_recipient? 
                # email_kind = EmailKind.user_emails.roundups("participant.project.category, #{timeline}-roundup", "RecipientParticipantRole")
             elsif participant.is_helper?
                # email_kind = EmailKind.user_emails.roundups("participant.project.category, #{timeline}-roundup", "HelperParticipantRole")
             else
                #weddings
             end
          end



        # participants_in_active_projects

      #removeV1
        puts "logged email #{project.category} #{email_kind.label}"
        puts "logged email #{email_kind.subject} "
   

    end


  end


end
