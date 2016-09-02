class CommitteeChairParticipantRole < CommitteeParticipantRole


  # def self.types
  #   [
  #     CommitteeParticipantRole, CommitteeChairParticipantRole
      
  #   ].flatten
  # end

  def kind
    'Committee Chair'
  end
  
  def icon_name
    'committee_chair'
  end

  def suggest_guests
    true
  end

  def see_guests
    true
  end

  def level
    3
  end

  def code
    6
  end


  private

    
end
