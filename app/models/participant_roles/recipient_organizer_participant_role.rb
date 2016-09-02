class RecipientOrganizerParticipantRole < RecipientParticipantRole


  def kind
    'Recipient/Organizer'
  end
  
  def icon_name
    'recipient_organizer'
  end



  def can_organize?
   true
  end

  def is_recipient?
    true
  end

  def rank
    1
  end
  
  def code
    2
  end



  private

end
