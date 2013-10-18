require "spec_helper"

describe Nutracoapi::Spree::ListOrders do
  it "should return a list of orders" do
    result = subject.list_paid_orders
    result.is_a?(Array).should be_true
    result.first.id.should_not be_nil
  end
end
