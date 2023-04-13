require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  describe "GET /show" do
    it 'has code 200' do
      id = Driver.first.id
      get "/drivers/#{id}"
      expect(response).to have_http_status(:success)
    end

    it 'has code 404 with invalid id' do
      get '/drivers/guacomole'
      expect(response).to have_http_status(:not_found)
    end

    it 'has code 400 with bad Directions Api request' do
      id = Driver.first.id
      Ride.create!(start_address:"bad address",end_address:"also bad")
      get "/drivers/#{id}"
      expect(response.code).to eq("400")
    end

    it 'has json content-type' do
      id = Driver.first.id
      get "/drivers/#{id}"
      expect(response.headers["Content-Type"]).to eq("application/json; charset=utf-8")
    end

    it 'returns 5 rides page 1' do
      id = Driver.first.id
      get "/drivers/#{id}?page=1&limit=5"
      body = JSON.parse(response.body)
      expect(body['rides'].count).to eq(5)
    end

    it 'returns unpaginated response' do
      id = Driver.first.id
      get "/drivers/#{id}"
      body = JSON.parse(response.body)
      expect(body['rides'].count).to eq(Ride.all.count)
    end

    it 'returns sorted list of rides in body by highest score' do
      id = Driver.first.id
      get "/drivers/#{id}"
      body = JSON.parse(response.body)
      scores = body['rides'].pluck('score')
      expect(scores.sort.reverse == scores).to be true
    end

    it 'returns all the correct keys' do
      id = Driver.first.id
      get "/drivers/#{id}"
      body = JSON.parse(response.body)
      expect(body.keys).to eq([
        "driverId",
        "driverHomeAddress",
        "rides",
           
          ]
        )
        expect(body["rides"].first.keys).to eq([
        "rideId",
        "rideScore",
        "rideEarnings",
        "rideDistance",
        "rideDuration",
        "rideStartAddress",
        "rideEndAddress" ])
    end
  end

  #test routing unmatched routes

  describe "DELETE" do
    it 'does not allow delete' do
      driver = Driver.first
      delete "/drivers/#{driver.id}"
      expect(response).to have_http_status(:not_found)
      expect(driver.destroyed?).to be false
    end
  end
end
