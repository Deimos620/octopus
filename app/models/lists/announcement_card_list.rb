class AnnouncementCardList < CardList 


    def self.types
    [
      # AnnouncementCardList,
      # WeddingAnnouncementCardList,
      BabyAnnouncementCardList,
      # GraduationAnnouncementCardList,
      ].flatten
  end

  def name
    "Announcement Mailing List"
  end

  def category_name
    "Announcement Card List"
  end

  def is_wedding?
    false
  end

  def is_baby?
    false
  end


  end