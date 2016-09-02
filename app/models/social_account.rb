class SocialAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :social_account_authorization

  has_many :social_shares
  has_many :authorized_users, through: :social_account_authorizations

  PLATFORMS = [:unknown, :twitter, :facebook, :pinterest, :instagram]

  enum platform: PLATFORMS

  after_create :add_internal_access

  scope :twitter, -> { where(plaform: "twitter") }
  scope :facebook, -> { where(plaform: "facebook") }




def adjusted_username
    if facebook?
      username
    elsif twitter?
      "@#{username}"
    end
  end


  def icon
    if facebook?
      "fa-facebook-square"
    elsif twitter?
      "fa-twitter"
    end
  end

  def add_internal_access
    # if internal?
      SocialAccountAuthorization.create!(user_id: 1, social_account_id: self.id)
      SocialAccountAuthorization.create!(user_id: 2, social_account_id: self.id)
    # end

  end

end
