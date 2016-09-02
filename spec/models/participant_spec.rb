require 'rails_helper'

RSpec.describe Participant, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:participant)).to be_valid
  end
end
