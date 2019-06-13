require 'rails_helper'

RSpec.describe "LikeTests", type: :request do
  describe "GET /like_tests" do
    it "works! (now write some real specs)" do
      get like_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
