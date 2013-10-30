require "spec_helper"

describe Nutracoapi::Spree::ShipOrder do
  it "should ship the order" do
    result = subject.ship_order("R852711767", "H46403128353", "123")
    result.number.should == "H46403128353"
    result.state.should == "shipped"
    result.tracking.should == "123"
  end
end
