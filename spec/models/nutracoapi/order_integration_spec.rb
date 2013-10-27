require 'spec_helper'

describe Nutracoapi::OrderIntegration do
  it {should validate_presence_of :order_number}
  it {should validate_presence_of :status}

  let(:shipped_oi){ Nutracoapi::OrderIntegration.create(:order_number => Time.now.to_i, :status => "shipped") }
  let(:non_shipped_oi){ Nutracoapi::OrderIntegration.create(:order_number => Time.now.to_i, :status => "integrated") }

  it "should fill status with integrated as default" do
     new_oi = Nutracoapi::OrderIntegration.create(:order_number => Time.now.to_i)
     new_oi.status.should == "integrated"
  end

  it "should not be was shipped when status is integrated" do
    non_shipped_oi.status.should == "integrated"
    non_shipped_oi.should_not be_was_shipped
  end

  it "should be was shipped when status is shipped" do
    shipped_oi.status.should == "shipped"
    shipped_oi.should be_was_shipped
  end

  it "should mark as shipped" do
    non_shipped_oi.should_not be_was_shipped
    non_shipped_oi.mark_as_shipped!
    non_shipped_oi.should be_was_shipped
  end
end
