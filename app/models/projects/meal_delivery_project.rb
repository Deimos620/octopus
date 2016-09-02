class MealDeliveryProject < Project

  accepts_nested_attributes_for :project_dates, allow_destroy: true
  accepts_nested_attributes_for :project_restrictions, allow_destroy: true
  # validates :in_honor, presence: true, allow_blank: false
  # validates :long_description, presence: true, allow_blank: false

  def self.model_name
    Project.model_name
  end

  def self.types
    [
      MealDeliveryProject,
      NewBabyMealDeliveryProject,  
      CareSupportMealDeliveryProject,
      
    ]
  end


  def proj_env
    'testing'
  end

  def subcategory_name
    'Basic Meal Delivery'
  end

  def category
    'Meal Delivery'
  end

  def icon_name
    'basic_meal_delivery'
  end

  def code
    5
  end 

  def kind
    "Meal Delivery"
  end  

  def is_meal_delivery?
    true
  end

  def is_party?
    false
  end

  def is_baby_related?
    false
  end

  def is_wedding_related?
   false
  end

  def short_title
    recipients = self.project_recipients
    if recipients.present?
      "Meal Deliveries" + " " + "for" + " " + recipients.map(&:first_name).join(' & ') 
    elsif recipients.blank? && self.honored_guests.present?
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



  

  def kind_project_path
    project_add_restrictions_path
  end



  # private
end
