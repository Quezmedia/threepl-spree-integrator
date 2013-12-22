require "spec_helper"

describe Nutracoapi::Broker::MissingOrdersSender do

  before do
    spree_result_obj = YAML::load(File.open("spec/resources/spree_order.yaml").read)

    spree_list_provider = double()
    spree_list_provider.stub(:list_paid_orders){[ spree_result_obj ]}
    subject.stub(:spree_list_provider){spree_list_provider}

    spree_find_provider = double()
    spree_find_provider.stub(:find_order){ spree_result_obj }
    subject.stub(:spree_find_provider){spree_find_provider}

    three_create_provider = double()
    three_create_provider.stub(:call_create_order).and_return("1")
    subject.stub(:three_create_provider){ three_create_provider }
  end

  it "should include the order to register" do
    expect{
      subject.send_missing_orders_to_three_pl
    }.to change{Nutracoapi::OrderIntegration.count}
  end
end

