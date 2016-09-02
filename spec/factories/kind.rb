FactoryGirl.define do
  factory :kind do
    title  { Faker::Name.first_name}
  end

   trait :meal_delivery do 
      kind 2
      project_type 'NewBabyMealDeliveryProject'
   end

end
