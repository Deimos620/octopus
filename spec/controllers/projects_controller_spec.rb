require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
    before do
      FactoryGirl.create(:project, :meal_delivery)
      sign_in FactoryGirl.create(:user)
    end
        it "Project Index" do
         get :index
        expect(response).to have_http_status(:success)
      end
end
