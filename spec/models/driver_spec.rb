require 'rails_helper'

RSpec.describe Driver, :type => :model do
  it "is valid with valid attributes" do
    d = Driver.new(home_address:"888 SE 9th Ave, Portland, OR 97214")
    expect(d.valid?).to be true
  end
  it "is not valid without a home address" do
    d = Driver.new()
    expect(d.valid?).to be false
  end
end