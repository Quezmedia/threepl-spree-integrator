require "spec_helper"

describe Nutracoapi::Spree::Base do
  it "api should be working" do
    response = subject.send(:call, :products)

    JSON.parse(response.body)["count"].should_not be_nil
  end
end

