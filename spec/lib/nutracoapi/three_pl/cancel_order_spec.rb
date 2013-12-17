require 'spec_helper'

describe Nutracoapi::ThreePl::CancelOrder do
  it "cancel order call should work" do
    warehouse_transaction_id = 974045
    response = subject.call_cancel_order(warehouse_transaction_id)

    response.should == "1"
  end
end

