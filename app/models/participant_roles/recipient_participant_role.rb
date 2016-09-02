class RecipientParticipantRole < ParticipantRole

  belongs_to :project, class_name: "RecipientParticipantRole",  foreign_key: "project_id"

  def self.types
    [
      RecipientParticipantRole, RecipientOrganizerParticipantRole
      
    ].flatten
  end

  def level
    1
  end

  def kind
    'Recipient'
  end
  
  def icon_name
    'recipient'
  end

  def is_recipient?
    true
  end

  def code
    4
  end


  #   after_create :add_honored_guest

  # def add_honored_guest
  #   honored_guest_added = HonoredGuest.where(email: self.participant.email)
  #   if honored_guest_added.blank? 
  #     HonoredGuest.create!(project_id: self.participant.project_id, passive: false, name: self.participant.name,
  #                           email: self.participant.email)
  #   end
  # end
  
  private

    

  # private
end
