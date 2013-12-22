require 'spec_helper'

describe Nutracoapi::OrderIntegration do
  it {should validate_presence_of :order_number}
  it {should validate_presence_of :status}
  it {should validate_presence_of :shipment_number}

  let(:non_shipped_oi){ subject.class.create(:order_number => Time.now.to_i, :status => "integrated", :shipment_number => "SHIPMENT") }
  let(:shipped_oi){ subject.class.create(:order_number => Time.now.to_i, :status => "shipped", :shipment_number => "SHIPMENT", :shipped_at => Time.now) }
  let(:canceled_oi){ subject.class.create(:order_number => Time.now.to_i, :status => "canceled", :shipment_number => "SHIPMENT", :canceled_at => Time.now) }

  it "should be already_saved" do
    order_number = non_shipped_oi.order_number
    subject.class.already_saved?(order_number).should be_true
  end

  it "should not be already_saved" do
    order_number = non_shipped_oi.order_number + 1000000
    subject.class.already_saved?(order_number).should be_false
  end

  it "should be canceled" do
    order_number = canceled_oi.order_number
    subject.class.already_canceled?(order_number).should be_true
  end

  it "should not be canceled" do
    order_number = non_shipped_oi.order_number
    subject.class.already_canceled?(order_number).should be_false
  end

  it "should fill status with integrated as default" do
     new_oi = subject.class.create(:order_number => Time.now.to_i)
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
    non_shipped_oi.mark_as_shipped!("TRACK")
    non_shipped_oi.tracking_number.should == "TRACK"
    non_shipped_oi.should be_was_shipped
  end

  it "should mark as canceled" do
    non_shipped_oi.should_not be_canceled
    non_shipped_oi.mark_as_canceled!
    non_shipped_oi.canceled_at.should_not be_nil
    non_shipped_oi.should be_canceled
  end

  it "should return only non shipped for scope non_shipped" do
    create_some_orders

    subject.class.all.count.should == 4
    subject.class.non_shipped_orders.count.should == 2
    subject.class.non_shipped_orders.each do |oi|
      oi.should_not be_was_shipped
    end
  end

  def create_some_orders
    subject.class.create(:order_number => Time.now.to_i, :status => "shipped", :shipment_number => "SHIPMENT")
    subject.class.create(:order_number => Time.now.to_i, :status => "shipped", :shipment_number => "SHIPMENT")
    subject.class.create(:order_number => Time.now.to_i, :status => "integrated", :shipment_number => "SHIPMENT")
    subject.class.create(:order_number => Time.now.to_i, :status => "integrated", :shipment_number => "SHIPMENT")
  end
end
