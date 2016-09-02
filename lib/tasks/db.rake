
require 'factory_girl'


namespace :db do




  task :foundation_data => :environment do

    puts 'adding email kinds'
    YAML.load_file('db/foundation_data/email_kinds.yml').each do |email_kind|
      EmailKind.create!(email_kind)
    end

    u = User.create!(first_name: 'Ada', last_name: 'SystemBrain', email: 'ada@ouroctopus.com', password: 'secretpassword123', time_zone: "Pacific Time (US & Canada)",
     confirmed_at: Time.now, gender: 'other', editor_user_id: 1, level: 'system', accept_terms: true)
    p = Profile.find_by_user_id(u.id)
    p.birth_date = Date.today
    p.website = 'http://www.ouroctopus.com'
    p.editor_user_id = 1
    p.save
    admin_email_kinds = EmailKind.admin_email 
    admin_email_kinds.each do |ek|
      EmailList.create!(user_id: u.id, email_kind_id: ek.id)
    end
    puts 'added Ada'


    u = User.create!(first_name: 'Emily', last_name: 'Wing', email: 'emilypwing@gmail.com', password: 'secretpassword123', time_zone: "Pacific Time (US & Canada)",
     confirmed_at: Time.now, gender: 'female', editor_user_id: 1, level: 'Maker', accept_terms: true)
    p = Profile.find_by_user_id(u.id)
    p.birth_date = Date.today - 37.years
    p.time_zone = 'Pacific Time (US & Canada)'
    p.website = 'http://www.emilywing.com'
    p.editor_user_id = 1
    p.save

    QueenAdminRole.create!(user_id: u.id, start_date: Date.today, editor_user_id: 1)
    admin_email_kinds = EmailKind.admin_email 
    admin_email_kinds.each do |ek|
      EmailList.create!(user_id: u.id, email_kind_id: ek.id)
    end

    puts 'added Emily'

    u = User.create!(first_name: 'DevFirst', last_name: 'DevLast', email: 'dev@ouroctopus.com', password: 'secretpassword123', time_zone: "Pacific Time (US & Canada)",
     confirmed_at: Time.now, gender: 'other', editor_user_id: 1, level: 'system', accept_terms: true)
    p = Profile.find_by_user_id(u.id)
    p.birth_date = Date.today
    p.website = 'http://www.ouroctopus.com'
    p.editor_user_id = 1
    p.save
    puts 'added Ada'


    puts 'adding internal social accounts'
    #refactor
    SocialAccount.create!(platform: "twitter", username: 'ouroctopus',  encrypted_password: 'SomePassword', )
    SocialAccount.create!(platform: "facebook", username: 'ouroctopus',  encrypted_password: 'SomePassword', )
    SocialAccount.create!(platform: "twitter", username: 'omghowmanycats',  encrypted_password: 'SomePassword', )
    SocialAccount.create!(platform: "facebook", username: 'omghowmanycats',  encrypted_password: 'SomePassword', )



    YAML.load_file('db/demo_data/demo_users.yml').each do |user|
      User.create!(user)
    end



    YAML.load_file('db/foundation_data/restrictions.yml').each do |restriction|
      Restriction.create!(restriction)
    end

    puts 'adding tags'
    YAML.load_file('db/foundation_data/blog_tags.yml').each do |tag|
      BlogTag.create!(tag)
    end

    puts 'adding categories'
    YAML.load_file('db/foundation_data/blog_categories.yml').each do |category|
      BlogCategory.create!(category)
    end
    YAML.load_file('db/foundation_data/blog_holidays.yml').each { |holiday| BlogHoliday.create!(holiday) }

    YAML.load_file('db/foundation_data/us_states.yml').each { |state| USState.create!(state) }

    YAML.load_file('db/foundation_data/countries.yml').each { |country| Country.create!(country) }
    # YAML.load_file('db/demo_data/demo_projects.yml').each do |p|
    #   Project.create!(p)
    # end
    puts "added foundation data"

  end

  task :blog_foundation_data => :environment do
   puts 'adding sections'
   YAML.load_file('db/foundation_data/blog_sections.yml').each do |b|
    BlogSection.create!(b)
  end
    # puts 'adding features'
    # YAML.load_file('db/foundation_data/blog_features.yml').each do |b|
    #   BlogFeature.create!(b)
    # end
    puts 'adding authors'
    YAML.load_file('db/foundation_data/blog_authors.yml').each do |b|
      BlogAuthor.create!(b)
    end

    YAML.load_file('db/foundation_data/meta_property_categories.yml').each do |mpc|
      MetaPropertyCategory.create!(mpc)
    end

    puts "added blog foundation data"
  end

  task :blog_sample_data => :environment do

   puts 'adding foundation pages'
   YAML.load_file('db/foundation_data/blog_static_pages.yml').each do |b|
    BlogPostStaticPage.create!(b)
  end
  puts 'adding demo posts'
  YAML.load_file('db/demo_data/demo_blog_posts.yml').each do |b|
    BlogPost.create!(b)
  end

  FactoryGirl.create_list(:blog_post, 32)


  posts = BlogPostOriginal.all
  posts.each do |post|
    post.generate_default_ranking
    section = rand(1..9)
    post.blog_section_id = section
    post.save
  end


  YAML.load_file('db/demo_data/demo_blog_references.yml').each do |b|
    BlogReference.create!(b)
  end



    # YAML.load_file('db/demo_data/demo_blog_editor_notes.yml').each do |b|
    #   BlogEditorNote.create!(b)
    # end
    
    puts "added blog sample data"
  end

  task :sample_data => :environment do
    u = User.find(2)
    p = NewBabyMealDeliveryProject.create!( prep_start_datetime: Date.today,  status: 1, long_description: 'desc',
      prep_end_datetime: Date.today + 2.weeks, max_visits: 5 )
    Address.create!(owner_type: "Project", owner_id: p.id, title: "CBGBs", address_1: "315 Bowery", city: "New York", us_state_id: 35 , postal_code: 10003 )
    HonoredGuest.create!(name: "Patti Smith", project_id: p.id)
    HonoredGuest.create!(name: "Leonard Cohen", project_id: p.id)
    par = Participant.create!(project_id: p.id, email: 'emilypwing@gmail.com', status: 3, user_id: u.id)
    op = OrganizerParticipantRole.create!(participant_id: par.id, grantor_participant_id: u.id, status: 3, editor_participant_id: par.id)

    p.organizer_participant_id = par.id
    p.editor_participant_id = par.id
    p.save

    assistants = User.where.not(id: 2)
    assistants.each do |a|
     par = Participant.create!(project_id: p.id, email: a.email, user_id: a.id, status: 1, invitor_participant_id: 1)
     pr = HelperParticipantRole.create!(participant_id: par.id, grantor_participant_id: u.id, editor_participant_id: op.id, status: 3 )
       # ProjectMailer.invite(par, pr, p.kind).deliver_later
     end

     puts 'adding social shares'
     FactoryGirl.create_list(:social_share, 32)
     new_social_shares = SocialShare.all
     new_social_shares.each do |social_share|
      last_share = SocialShare.order(updated_at: :desc).first
      social_share.scheduled_datetime = last_share.scheduled_datetime.to_date + 1.day
      social_share.tweet = social_share.copy
      social_share.save
    end
    new_social_shares.shuffle.take(20).each do |social_share|
      social_share.social_account_id = 2
      social_share.save
    end

    puts 'loaded sample data'
  end

   task :tweaks => :environment do #local dev tweeks
    EmailKind.where.not(id: 1).destroy_all
    puts 'adding email kinds'
    YAML.load_file('db/foundation_data/email_kinds.yml').each do |email_kind|
      EmailKind.create!(email_kind)
    end

    puts 'adding blog post rankings '
    BlogPostRanking.destroy_all

    YAML.load_file('db/demo_data/demo_blog_post_rankings.yml').each do |ranking|
      BlogPostRanking.create!(ranking)
    end
  end
end
