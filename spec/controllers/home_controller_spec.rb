require 'rails_helper'

RSpec.describe HomeController, type: :controller do

      it "it's visible" do
        get :index
        expect(response).to have_http_status(:success)
      end

end
