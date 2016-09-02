FactoryGirl.define do
  factory :user, aliases: [:editor_user] do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password "supersecret"
    password_confirmation "supersecret"
    accept_terms true
    confirmed_at Time.now

      trait :not_accepted do
        accept_terms false
      end
      trait :unconfirmed do
        confirmed_at nil
      end
      

    level "user"

    #  after(:create) { |f| 
    #    f.profile.create!(birth_date: Date.today - 21.years)
    # }
    
    
  end

end
