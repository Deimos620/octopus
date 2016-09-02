require 'rails_helper'

RSpec.describe "ProjectRestrictions", type: :request do
  describe "GET /project_restrictions" do
    it "works! (now write some real specs)" do
      get project_restrictions_path
      expect(response).to have_http_status(200)
    end
  end
end
