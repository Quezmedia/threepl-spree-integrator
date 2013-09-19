require 'spec_helper'

describe Nutracoapi do
  it "should return data for a named element" do
    Nutracoapi::VERSION.should_not be_nil
  end
end
