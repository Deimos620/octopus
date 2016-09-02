class CoorganizerParticipantRole < CommitteeParticipantRole

  def kind
    'Co-Organizer'
  end
  
  def icon_name
    'coorganizer'
  end

  def is_primary_organizer?
    false
  end

  def can_organize?
    true
  end

  def level
    2
  end

  def code
    7
  end


  private

    
end
