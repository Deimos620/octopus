class BlogPostRanking < ActiveRecord::Base
  belongs_to :blog_post
  include BasicScopes

   CATEGORIES = [:unkown, :popular, :featured, :trending]


  #Add new statuses to the end of the list. If you change this order of these than it will break the data.  
  enum category: CATEGORIES

  scope :current_as_of, -> (date) do
    where('start_date <= ?',date).
    where('(end_date >= ? or end_date IS NULL)', date)
  end

  scope :popular, -> { where(category: 1) }
  scope :featured, -> { where(category: 2) }
  scope :trending, -> { where(category: 3) }


  


  before_save :set_start_date
  before_save :set_expiration_date

  
  def set_start_date
    if self.start_date.present?
      start_date
    else
      start_date = self.blog_post.published_datetime
    end
  end

  def set_expiration_date
    if self.start_date.present?
      end_date = self.start_date + 1.week
    else
      end_date = self.blog_post.published_datetime + 1.week
    end
  end

end

