require "spec_helper"

describe Nutracoapi::BrokerThreeToSpree do
  def create_scenario_orders
    Nutracoapi::OrderIntegration.create! order_number: 1, shipment_number: "1"
    Nutracoapi::OrderIntegration.create! order_number: 2, shipment_number: "2"
    Nutracoapi::OrderIntegration.create! order_number: 3, shipment_number: "3", tracking_number: "3", status: "shipped"
    Nutracoapi::OrderIntegration.create! order_number: 4, shipment_number: "4", tracking_number: "4", status: "shipped"
  end
  before do
    spree_ship_provider = double()
    spree_ship_provider.should_receive(:ship_order).exactly(2).times
    subject.stub(:spree_ship_provider){ spree_ship_provider }

    three_find_order_provider = double()
    three_find_order_provider.should_receive(:call_find_order).exactly(2).times.and_return(OpenStruct.new.tap{|o| o.tracking_number = Time.now.to_i})
    subject.stub(:three_find_order_provider){ three_find_order_provider }
  end

  before(:each) do
    create_scenario_orders
  end

  it "should mark unshipped orders as shipped" do
    expect {subject.check_and_mark_orders_as_sent }.to change{ Nutracoapi::OrderIntegration.non_shipped_orders.count }.by(-2)
    Nutracoapi::OrderIntegration.all.each do |oi|
      oi.tracking_number.should_not be_nil
    end
  end
end
