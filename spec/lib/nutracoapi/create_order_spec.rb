require 'spec_helper'

describe Nutracoapi::CreateOrder do
  it "create order call should work" do
    response = subject.call_create_order(:reference_num => "Test123")
    pp response.body
  end
end

