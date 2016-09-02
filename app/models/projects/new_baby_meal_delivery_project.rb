class NewBabyMealDeliveryProject < MealDeliveryProject

  
  
  def proj_env
    'testing'
  end

  def subcategory_name
    'New Baby Meal Delivery'
  end

  def icon_name
    'new_baby_meal_delivery'
  end

  def category
    'Meal Delivery'
  end

  def code
    1
  end  

  def rank
    2
  end

  def is_meal_delivery?
    true
  end

  def is_party?
    false
  end

  def is_baby_related?
    true
  end

  def is_wedding_related?
   false
  end




  private

    

  # private
end
