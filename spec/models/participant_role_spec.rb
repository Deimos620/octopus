require 'rails_helper'

RSpec.describe ParticipantRole, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:participant_role)).to be_valid
  end
end
