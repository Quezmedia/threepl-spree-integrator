require 'spec_helper'

describe Nutracoapi::ThreePl::FindOrder do
  it "find order call should work" do
    reference_num = 1382812251
    response = subject.call_find_order(reference_num)

    response.is_a?(Array).should be_true
    response.first.customer_name.should_not be_nil
  end
end

