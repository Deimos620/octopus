class Flag < ActiveRecord::Base

  #enums
    STATUSES = [:unspecified, :unseen, :seen, :fixed, :rejected]
  enum status: STATUSES

      CATEGORIES = ["Potential Household", "Stuffed", "Emailed", "Addressed", "Address Verified", "Mailed", "RSVP Received"]

end
