FactoryGirl.define do
  factory :project do
    type 'Project'
    prep_start_datetime Date.today
    in_honor  { Faker::Name.first_name}
    association :kind


    trait :new_baby_meal_delivery do ##
      type 'NewBabyMealDeliveryProject'
      in_honor  { Faker::Name.first_name}
      max_visits 3
      prep_start_datetime Date.today - 1.day
      prep_end_datetime Date.today + 1.week
      association :kind, :meal_delivery
    end
    # after(:create) do |project, evaluator|
    #     # @user = FactoryGirl.create(:user)

    #     create(:organizer_participant_role,  status: 3)
    # end

  end

end
