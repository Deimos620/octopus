
Rails.application.config.middleware.use OmniAuth::Builder do
    # provider :developer unless Rails.env.production?

    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
    {
      :scope => 'email, public_profile',
      :info_fields => 'name, email, first_name, last_name, gender, location, locale',
    }
    provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], 
     {
      :name => "google_oauth2",
      :scope => "email, profile, plus.me",
      :prompt => "select_account",
      :image_aspect_ratio => "square",
      :image_size => 50
    }
end