class Attendee < ActiveRecord::Base
  belongs_to :participant
  belongs_to :event
  enum status: [:unknown, :pending, :accepted, :declined]

end
