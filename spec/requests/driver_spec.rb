require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  describe "GET /show" do
    it 'has code 200' do
      get '/drivers/1'
      expect(response).to have_http_status(:success)
    end

    it 'has code 404 with invalid id' do
      get '/drivers/guacomole'
      expect(response).to have_http_status(:missing)
    end

    it 'returns 5 rides page 1' do
      get '/drivers/1?page=1&limit=5'
      body = JSON.parse(response.body)
      expect(body['rides'].count).to eq(5)
    end

    it 'returns sorted list of rides in body by highest score' do
      get '/drivers/1'
      body = JSON.parse(response.body)
      scores = body['rides'].pluck('score')
      expect(scores.sort.reverse == scores).to be true
    end
  end
end
