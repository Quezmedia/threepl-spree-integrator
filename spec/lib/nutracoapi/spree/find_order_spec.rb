require "spec_helper"

describe Nutracoapi::Spree::FindOrder do
  it "should return an order" do
    result = subject.find_order("R131778586")
    result.number.should == "R131778586"
  end
end
