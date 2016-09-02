class HonoredGuest < ActiveRecord::Base
  belongs_to :project
  belongs_to :participant
  belongs_to :participant_title

  scope :uninvited, -> { where(participant_id: nil) }
  scope :invited, -> { where.not(participant_id: nil) }

  scope :invitable, -> { where(participant_id: nil).where(passive: false) }
  scope :completed, -> { where('participant_id != ? or passive = ?', nil, true)}
  scope :passive, -> { where(passive: true) }




  def invited?
    self.participant_id.present? or self.passive?
  end

  def completed_name
    if self.participant_id.present? &&  self.participant.user_id.present?
      self.participant.name
    elsif self.participant_id.blank? && self.passive?
      self.name 
    else
      self.name
    end

  end

  def completed_short_name
    if self.participant_id.present? &&  self.participant.user_id.present?
      self.participant.first_name
    elsif self.participant_id.blank? && self.passive?
      self.name 
    else
      self.name
    end

  end




  def invited_name
    if self.participant_id.present? &&  self.participant.user_id.present?
      self.participant.name
    elsif   self.participant_id.present? &&  self.participant.user_id.blank? && self.name.blank?
      self.email
    else
      self.name
    end
  end
end
