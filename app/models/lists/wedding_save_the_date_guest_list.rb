class WeddingSaveTheDateGuestList < GuestList


   

  def name
    "Wedding Save the Date List"
  end

  def category_name
    "Guest List"
  end

  def is_wedding?
    true
  end

  def is_baby?
    false
  end

  def recipient_name
    "guest"
  end

 end