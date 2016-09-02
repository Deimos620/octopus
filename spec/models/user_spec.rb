# require 'rails_helper'

RSpec.describe User, type: :model do
   it "has a valid factory" do
      expect(FactoryGirl.build(:user)).to be_valid
  end

   it "profile is always created" do
      @user = FactoryGirl.build(:user)
      @profile = Profile.where(user_id: @user.id).first
      expect(@profile)
  end
end
