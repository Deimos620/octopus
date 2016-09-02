class ProjectDate < ActiveRecord::Base
  paginates_per 7
  
  belongs_to :project
  has_many :events, dependent: :destroy
  has_many :blocked_times, dependent: :destroy

  default_scope -> { order(schedule_date: :asc)}
    scope :available, -> { where(available: true) }
    scope :more_available, -> { where(available: true) }#if more than one
    scope :unavailable, -> { where(available: false) }
    scope :past, -> { where( "schedule_date < '#{(Time.current)}' ") }
    scope :present, -> { where( "schedule_date > '#{(Time.current)}' ") }
    scope :appointments, -> { ProjectDate.joins(events: (:project_date_id )) }
  
    accepts_nested_attributes_for :events
    accepts_nested_attributes_for :blocked_times

  def current_as_of?(date)
    if schedule_date >=date
      true
    elsif schedule_date < date
      false
    else

    end
  end

  def ended_as_of?(date)
    !current_as_of?(date)
  end

  def current?
    self.current_as_of?(Date.today)
  end

  def is_today?
    self.schedule_date == Date.today
  end

  def ended?
    !current?
  end

  def has_maxiumum_visits?
    if self.events.count >= self.project.max_visits.to_i
      true
    else
      false
    end
  end

  # schedule_date  < DateTime.now.to_date  

  def earliest_available_time
    self.project.time_start || "09:00:00"
  end

end
