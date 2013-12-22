require "spec_helper"

describe Nutracoapi::Broker::CanceledOrdersSender do

  before do
    spree_result_obj = YAML::load(File.open("spec/resources/spree_canceled_order.yaml").read)

    spree_list_provider = double()
    spree_list_provider.stub(:list_canceled_orders){[ spree_result_obj ]}
    subject.stub(:spree_list_provider){spree_list_provider}

    three_result_obj = double()
    three_result_obj.stub(:warehouse_transaction_id).and_return("111")

    three_find_provider = double()
    three_find_provider.stub(:call_find_order){ [ three_result_obj ] }
    subject.stub(:three_find_provider){three_find_provider}

    three_cancel_provider = double()
    three_cancel_provider.stub(:call_cancel_order).and_return("1")
    subject.stub(:three_cancel_provider){ three_cancel_provider }

    Nutracoapi::OrderIntegration.create! order_number: "R3188231992", shipment_number: "3", tracking_number: "3", status: "shipped"
  end

  it "should include the order to register" do
    expect{
      subject.send_canceled_orders_to_three_pl
    }.to change{Nutracoapi::OrderIntegration.canceled_orders.count}
  end
end

