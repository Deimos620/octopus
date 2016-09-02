FactoryGirl.define do
  factory :participant, aliases: [:organizer_participant, :recipient, :sender, :event_organizer ] do
    email      { Faker::Internet.email }
  

     trait :organizer_participant do
        status 3
        association :user
        after(:create) do |participant, evaluator|
          create(:organizer_participant_role, participant: participant)
        end
     end

     trait :invited_participant do
        status 1
     end

      trait :confirmed_participant do
        status 3
        association :user
     end
    
  end

end
