require 'spec_helper'

describe Nutracoapi::ThreePl::CreateOrder do
  it "create order call should work" do
    response = subject.call_create_order(
      :reference_num => Time.now.to_i,
      :company_name  => "Test Company Name",
      :address1      => "Blablabla",
      :city          => "Lost Angeles",
      :state         => "Ca",
      :zip           => "90010",
      :country       => "US",
      :carrier       => "UPS",
      :mode          => "Ground",
      :billing_code  => "FreightCollect",
      :account       => "12345675",
      :notes         => "This is a note",
      :products      => {
        :TestItem => 1
      },
    )
    response.body[:int32].should == "1"
  end
end

