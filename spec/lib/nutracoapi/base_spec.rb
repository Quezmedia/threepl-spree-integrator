require 'spec_helper'

describe Nutracoapi::Base do
  it "api should be working" do
    response = subject.send(:call, :report_stock_status)
    response.body[:string].should match(/MyDataSet/)
  end
end

