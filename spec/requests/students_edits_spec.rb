require 'rails_helper'

RSpec.describe "StudentsEdits", type: :request do
  describe "GET /students_edits" do
    it "works! (now write some real specs)" do
      get students_edits_path
      expect(response).to have_http_status(200)
    end
  end
end
