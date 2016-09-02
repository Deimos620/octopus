class List < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :list_recipients, dependent: :destroy
  has_many :guests, through: :list_recipients


  #make sure to archive after project archived
  enum status: [:draft, :active, :archived]

  def self.types
    [
      GuestList.types,
      CardList.types,
      ThankYouList.types,
      ].flatten
  end

  def name
    "List"
  end

  def category_name
    "Mailing List"
  end

  def is_wedding?
    false
  end

  def is_baby?
    false
  end

  def recipient_name
    "recipient"
  end


end
