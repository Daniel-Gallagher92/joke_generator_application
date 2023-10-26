require 'rails_helper'

RSpec.describe "Jokes", type: :request do
  describe "GET /jokes" do
    it "fetches a dad joke" do

      get jokes_path
      
      expect(response).to have_http_status(200)
    end
  end
end
