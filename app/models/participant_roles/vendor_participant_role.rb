class VendorParticipantRole < ParticipantRole



  def kind
    'Vendor'
  end
  
  def icon_name
    'vendor'
  end

  def level
    10
  end


  # We always want to load our ratings information
  # default_scope { includes(:rating) }


  # Convenience methods to find out if we're current
  # TODO: This is copied and pasted from Role

  def current_as_of?(date)
    if end_date && end_date < date
      false
    else
      true
    end
  end

  def ended_as_of?(date)
    !current_as_of?(date)
  end

  def current?
    current_as_of?(Date.today)
  end

  def ended?
    !current?
  end

  def has_active_flags?
    flags.any?{|f|f.active?}
  end


  

  def is_helper?
    false
  end




  private

    

  # private
end
