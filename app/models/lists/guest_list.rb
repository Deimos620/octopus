class GuestList < List


    def self.types
    [
      GuestList,
      WeddingSaveTheDateGuestList,
      WeddingGuestList,
      # ShowerGuestList.types,
      # PartyGuestList,
      ].flatten
  end

  def name
    "Guest Mailing List"
  end

  def category_name
    "Guest List"
  end

  def is_wedding?
    false
  end

  def is_baby?
    false
  end

  def recipient_name
    "guest"
  end

 end