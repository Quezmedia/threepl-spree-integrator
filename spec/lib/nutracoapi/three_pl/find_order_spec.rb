require 'spec_helper'

describe Nutracoapi::ThreePl::FindOrder do
  it "find order call should work" do
    reference_num = 1382031184
    response = subject.call_find_order(reference_num)

    response[:parsed_response].customer_name.should_not be_nil
    response[:total_orders].should == 1
  end
end

