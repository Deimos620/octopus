require 'rails_helper'

RSpec.describe "ProjectDates", type: :request do
  describe "GET /project_dates" do
    it "works! (now write some real specs)" do
      get project_dates_path
      expect(response).to have_http_status(200)
    end
  end
end
