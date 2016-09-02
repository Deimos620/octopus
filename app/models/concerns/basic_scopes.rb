module BasicScopes
  extend ActiveSupport::Concern

  included do

   #  #calendar 
    scope :just_added, -> { where('created_at >= ?', Date.current)}
   	scope :due_today, -> { where(due_date: Date.now)}
   	scope :just_added, -> { where('created_at >= ?', Date.now)}
    # scope :overdue, -> { where('due_date < ?', Time.now)}
    # scope :upcoming, -> { where('due_date > ?', Time.now)} 
    # scope :this_week, -> { where('starts_on > ?', Time.now).where('starts_on < ?', Time.now + 1.week)}
    # scope :tomorrow, -> { where('starts_on > ?', Date.current + 1.day)}
    scope :week_old, -> { where('created_at <= ?', 7.days.ago)}
    scope :new_this_week, -> { where.not("created_at >= ?", Time.zone.now.beginning_of_day - 1.week)}
    scope :new_this_month, -> { where.not("created_at >= ?", Time.zone.now.beginning_of_day - 1.month)}
    scope :new_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day)}
    scope :just_added, -> { where('created_at >= ?', Date.current)}
    scope :recently_created, -> { order(created_at: :desc)}
    scope :recently_updated, -> { order(updated_at: :desc)}
    scope :day_old, -> { where('created_at <= ?', 1.day.ago)}

    scope :updated_after, -> (date) do
      where('updated_at >= ?',date)
    end
    scope :has_been_updated, -> { where("updated_at != created_at")}

     

  end


end