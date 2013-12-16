require "spec_helper"

describe Nutracoapi::Spree::ShipOrder do
  it "should ship the order" do
    result = subject.ship_order("R131778586", "H44833725578", "123")
    result.number.should == "H44833725578"
    result.state.should == "shipped"
    result.tracking.should == "123"
  end
end
