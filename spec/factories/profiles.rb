FactoryGirl.define do
  factory :profile do
    association :user
    website     { Faker::Internet.http_url}       
    phone  {Faker::PhoneNumber.short_phone_number}
    is_vendor false
    
    trait :vendor do 
      is_vendor true
      vendor_name  { Faker::Name.first_name}
    end


  end

end
