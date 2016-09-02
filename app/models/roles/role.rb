class Role < ActiveRecord::Base

  belongs_to :user
  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"


   # --- VALIDATIONS ---

  #STI Requires Type
  validates :type, presence: true, allow_blank: false

  def self.types
    [
      AdminRole.types
      
    ].flatten
  end

  scope :current_as_of, -> (date) do
    where('start_date <= ?',date).
    where('(end_date >= ? or end_date IS NULL)', date)
  end
  scope :expired_as_of, -> (date) do
    where('start_date <= ?',date).
    where('(end_date < ? )', date)
  end

  def current_as_of?(date)
    if end_date && end_date < date
      false
    else
      true
    end
  end

  def ended_as_of?(date)
    !current_as_of?(date)
  end

  def current?
    current_as_of?(Date.today)
  end

  def ended?
    !current?
  end

  
  # --- CALLBACKS ---

  before_save :calculate_end_date, if: :new_record?
  before_save :calculate_start_date, if: :new_record?


  def calculate_end_date
    self.end_date || self.end_date = Date.today + 2.years
  end

  def calculate_start_date
    self.start_date || self.start_date = Date.today 
  end

end
