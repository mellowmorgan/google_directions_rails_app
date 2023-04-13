require 'rails_helper'

RSpec.describe Ride, :type => :model do
  it "is valid with valid attributes" do
    r = Ride.new(start_address:"888 SE 9th Ave, Portland, OR 97214", end_address: "20778 Hello World, Paris, France")
    expect(r.valid?).to be true
  end
  it "is not valid without start and end address" do
    r = Ride.new(start_address: "My friend's house")
    expect(r.valid?).to be false
  end
end