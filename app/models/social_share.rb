class SocialShare < ActiveRecord::Base
  belongs_to :social_account
  belongs_to :blog_post

  STATUSES = [:draft, :scheduled, :shared, :failed, :archived]

  enum status: STATUSES

  scope :internal, -> { where(internal: true) }
  scope :scheduled, -> { where(status: 1) }
  scope :scheduled_tomorrow, -> { where(scheduled_datetime: Date.today + 1.day )}
  scope :scheduled_today, -> { where(scheduled_datetime: Date.today  )}
  scope :scheduled_this_week, -> { where("scheduled_datetime >= ?", Date.today + 1.day).where("scheduled_datetime <= ?", Date.today + 8.days)}
  scope :past, -> { where(status: 3).where("scheduled_datetime <= ?", Date.today)}


  #add sharing authentications

  def is_scheduled_for(timeline)
    if timeline == "tomorrow"
      self.scheduled_tomorrow.present?
    elsif timeline == "today"
      self.scheduled_today.present?
    elsif timeline == "this_week"
      self.scheduled_this_week.present?
    end
  end


  def status_label
    case status ? status.to_s : nil
      when "shared"
        "success"
      when "scheduled"
        "warning"
      when "draft"
        "default"
      when "failed"
        "danger"
      when "archived"
        "violet"
      end
  end

  def icon
    self.social_account.icon
    # if self.social_account.facebook?
    #   "fa-facebook-square"
    # elsif self.social_account.twitter?
    #   "fa-twitter"
    # end
  end

  def display_copy
    if self.social_account.facebook?
      copy
    elsif self.social_account.twitter?
      tweet
    end
  end


end
