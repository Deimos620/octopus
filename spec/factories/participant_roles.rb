FactoryGirl.define do
  factory :participant_role do
    type 'HelperParticipantRole'
    association :participant
  end

  factory :organizer_participant_role, parent: :participant_role, class: OrganizerParticipantRole do
    association :participant
  end 

end
