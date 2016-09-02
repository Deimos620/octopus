    require 'twitter'

    client = Twitter::REST::Client.new do |config|
      config.consumer_key        =  ENV['TWITTER_CONSUMER_KEY'] 
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET'] 
      # config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      # config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end


# accounts = {}
# SocialAccount.twitter.each do |twitter_account|
#     username = twitter_account['username']
#     token = twitter_account['access_token']
#     secret = twitter_account['access_token_secret']

#     accounts[username] = Twitter::Client.new(
#         :oauth_token => token,
#         :oauth_token_secret => secret


#     )
# end

# Thread.new{accounts['erik'].update('test')} 

