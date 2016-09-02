class PartyProject < Project

  def self.types
    [
      PartyProject,
      WeddingProject,
      # ShowerProject
      
    ]
  end


  def proj_env
    'testing'
  end

  def subcategory_name
    'Basic Party'
  end

  def category
    'Party'
  end

  def icon_name
    'basic_party'
  end

  def code
    3
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
   false
  end




  private

    

  # private
end
