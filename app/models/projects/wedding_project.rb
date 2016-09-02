class WeddingProject < PartyProject


  def self.model_name
    Project.model_name
  end

  def proj_env
    'testing'
  end

  def subcategory_name
    'Basic Meal Delivery'
  end

  def category
    'Wedding'
  end

  def icon_name
    'wedding'
  end

  def code
    5
  end 

  def kind
    "Wedding"
  end  

  def is_meal_delivery?
    false
  end

  def is_party?
    true
  end

  def is_baby_related?
    false
  end

  def is_wedding_related?
   true
  end

  def short_title
    recipients = self.project_recipients
    if recipients.present?
      "Meal Deliveries" + " " + "for" + " " + recipients.map(&:first_name).join(' & ') 
    elsif self.honored_guests.present?
      "Meal Deliveries for #{honored_guests.map(&:completed_short_name).join(' & ') }"
    else
      subcategory_name
    end
  end

  def full_title
    recipients = self.project_recipients

    if recipients.present?
      # template_name + " " + 'for'  rescue self.project_recipients.map(&:first_name).join(' & ') + "" rescue "" 
      subcategory_name.pluralize + " " + 'for'  + " " +  recipients.map(&:name).join(' & ')  
    elsif recipients.blank? && self.honored_guests.present?

    "#{subcategory_name.pluralize} for #{honored_guests.map(&:completed_name).join(' & ') }"
    # 'edos'
    else
      subcategory_name.pluralize
    end
  end




  # private
end
