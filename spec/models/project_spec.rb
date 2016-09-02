require 'rails_helper'

RSpec.describe Project, type: :model do
  it "has a valid factory" do 
    expect(FactoryGirl.build(:project)).to be_valid
  end

  describe "a New Baby Meal DeliveryProject + Dates + Organizer Suite" do

    before do 
     @meal_delivery_project = FactoryGirl.create(:project, :new_baby_meal_delivery)
     @organizer_participant = FactoryGirl.create(:participant, :organizer_participant)#
     @meal_delivery_project.update_attributes(organizer_participant_id: @organizer_participant.id)
     @user = User.find( @organizer_participant.user_id)#
     @organizer_participant_role = FactoryGirl.create(:organizer_participant_role)
     @organizer_participant_role.update_attributes(participant_id: @organizer_participant.id, project_id: @meal_delivery_project.id)

    end

    it "has a valid NEW BABY MEAL DELIVERY factory" do 
      expect(@meal_delivery_project.valid?).to be true
    end

     it "has an  participant with a user" do 
      expect(@organizer_participant.valid?).to be true
      expect(@user.valid?).to be true
    end

    it "has an organizer participant role " do 
      expect(@organizer_participant_role.valid?).to be true
    end

    


  end

end
