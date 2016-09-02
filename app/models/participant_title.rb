class ParticipantTitle < ActiveRecord::Base
  belongs_to :participant
  has_one :honored_guest
end
