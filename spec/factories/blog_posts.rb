FactoryGirl.define do
  factory :blog_post do
    editor_user_id 2
    blog_editor_user_id 2
    blog_author_id 1
    type "BlogPostOriginal"
    title       { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraphs(4)}
    published_datetime Date.today - 1.week
    status "scheduled"
    sequence(:slug)      { |n| "slug#{n}" }
  end

end
