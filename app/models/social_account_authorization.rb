class SocialAccountAuthorization < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_account
  has_many :social_shares, through: :social_account
end
