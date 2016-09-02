FactoryGirl.define do
  factory :social_share do
    social_account_id 1
    copy       { Faker::Lorem.sentence}
    editor_user_id       2    
    scheduled_datetime Time.now - 1.week
  end

end


