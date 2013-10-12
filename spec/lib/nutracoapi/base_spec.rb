require 'spec_helper'

describe Nutracoapi::Base do
  it "api should be working" do
    response = subject.send(:call, "ReportStockStatus", {}, {:userLoginData => Nutracoapi.login_parameters})
    response.body[:string].should match(/MyDataSet/)
  end
end

