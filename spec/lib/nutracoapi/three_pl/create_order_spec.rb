require 'spec_helper'

describe Nutracoapi::ThreePl::CreateOrder do
  it "create order call should work" do
    reference_num = Time.now.to_i
    response = subject.call_create_order(
      :reference_num => reference_num,
      :company_name  => "Test Company Name",
      :address1      => "Blablabla",
      :city          => "Lost Angeles",
      :state         => "Ca",
      :zip           => "90010",
      :country       => "US",
      :carrier       => "UPS",
      :mode          => "Ground",
      :billing_code  => "Prepaid",
      :notes         => "This is a note",
      :products      => {
        :TestItem => 1
      },
    )
    response.should == "1"
  end
end

