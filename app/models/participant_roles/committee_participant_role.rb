class CommitteeParticipantRole < HelperParticipantRole


  def self.types
    [
      CommitteeParticipantRole, CommitteeChairParticipantRole
      
    ].flatten
  end

  def kind
    'Committee Member'
  end
  
  def icon_name
    'committee'
  end

  def suggest_guests
    true
  end

  def see_guests
    true
  end

  def level
    4
  end

  def code
    5
  end


  private

    
end
