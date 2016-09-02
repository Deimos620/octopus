class CareSupportMealDeliveryProject < MealDeliveryProject

  
  def proj_env
    'testing'
  end

  def subcategory_name
    'Care & Support Meal Delivery'
  end

  def icon_name
    'care_support_meal_delivery'
  end

  def category
    'Meal Delivery'
  end

  def code
    2
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




  private

    

  # private
end
