class CardList < List


    def self.types
    [
      CardList,
      # HolidayCardsList.types,
      # ThankYouCardList.types,
      AnnouncementCardList.types,
      ].flatten
  end

  def name
    "Card List"
  end

  def category_name
    "Card Mailing List"
  end

  def is_wedding?
    false
  end

  def is_baby?
    false
  end


  end