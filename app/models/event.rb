class Event < ActiveRecord::Base
  belongs_to :project_date
  has_many :attendees, dependent: :destroy
  belongs_to :participant
  accepts_nested_attributes_for :attendees

  enum status: [:unknown , :unfinished, :finished, :pending, :approved, :reschedule]


  def is_answered?
    if self.status == "approved" or self.status == "reschedule" && self.status != "finished" &&   self.status != "unfinished"
      true
    else
      false
    end
  end

  def status_badge
    case status.present? 
      when self.finished?
        "label-default"
      when self.unfinished?
        "label-default"
      when self.reschedule?
        "label-danger"
      when self.approved?
        "label-success"
      when self.pending?
        "label-warning"
    end
  end

  def status_text
    case self.status.present?
      when self.finished?
        "ready to invite"
      when self.unfinished?
        "unfinished"
      when self.reschedule?
        "please reschedule"
      when self.approved?
         self.status
      when self.pending?
        self.status
    end
  end

  def start_date_and_time
    if self.date_start?
      if self.time_start.present?
        "#{self.date_start.strftime("%b. %e, %Y ")}" + "at " + "#{self.time_start.strftime("%l:%M %P") }"
      else
        "#{self.date_start.strftime("%b. %e, %Y ")}"
      end
    end
  end

  def time_start_formatted
    if self.time_start.present?
      self.time_start.strftime("%l:%M %P")
    end
  end

  def time_end_formatted
    if self.time_end.present?
      self.time_end.strftime("%l:%M %P")
    end
  end

  before_save :default_date_start
  after_create :add_attendees
  after_update :response_info, unless: :new_record?

  private
  
  def default_date_start
    if self.project_date_id.present?
      self.date_start = self.project_date.schedule_date
      self.date_end = self.project_date.schedule_date
    end
  end

  def response_info
    # if self.project_id.present?
    #   if self.status == "reschedule" && self.time_start.present? && self.time_end.present?
    #     BlockedTime.create!(time_start: self.time_start, time_end: self.time_end, project_date_id: self.project_date_id)
    #   end
    #     EventResponseJob.perform(self, self.status)
    # end
  end

  def add_attendees
    # project = Project.find(self.project_date.project_id)
    EventAttendeesJob.perform(self, "add")
   
  end

  
end
