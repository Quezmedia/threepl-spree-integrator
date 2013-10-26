require "spec_helper"

describe Nutracoapi::Spree::FindOrder do
  it "should return an order" do
    result = subject.find_order("R267844288")
    result.number.should == "R267844288"
  end
end
