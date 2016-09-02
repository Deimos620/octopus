class SocialShareJob < ActiveJob::Base
	# queue_as :mailers
  def self.perform(social_share_id)
    # @social_shares = 
    @social_share = SocialShare.find(social_share_id)
  end   
end



