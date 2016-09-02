class OrganizerParticipantRole < ParticipantRole


  def self.types
    [
      OrganizerParticipantRole, CoorganizerParticipantRole
      
    ].flatten
  end

  def level
    1
  end

  def kind
    'Organizer'
  end

  def code
    1
  end

  
  def icon_name
    'organizer'
  end

  def is_organizer?
    true
  end

  def is_primary_organizer
    true
  end

  def see_budget
    true
  end

  def see_guests
    true
  end

  def invite_guests
    true
  end

  def suggest_guests
    true
  end



  def can_organize?
    true
  end



  private

    
end
