require_relative "../../app/lib/directions_api.rb"

describe DirectionsApi do
  describe "#get_maps_info" do
    it "should return hash with distance and durations values" do
      origin = "888 SE 9th Ave, Portland, OR 97214" 
      destination = "The Last Bookstore, Los Angeles, CA" 
      result = DirectionsApi.new.get_maps_info(origin, destination)
      expect(result.class).to be Hash
      expect(result.keys).to match_array([:distance,:duration])
    end
    it "should raise error for invalid addresses" do
      origin = "Powells Books W Burnside" 
      destination = "Behind the Museum Cafe Portland" 
      expect{DirectionsApi.new.get_maps_info(origin, destination)}.to raise_error
    end
  end
end