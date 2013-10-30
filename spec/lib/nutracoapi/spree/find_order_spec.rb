require "spec_helper"

describe Nutracoapi::Spree::FindOrder do
  it "should return an order" do
    result = subject.find_order("R582777812")
    result.number.should == "R582777812"
  end
end
