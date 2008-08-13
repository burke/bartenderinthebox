require File.dirname(__FILE__) + '/../spec_helper'

describe Reservoir do
  before(:each) do
    @reservoir = Reservoir.new
  end

  it "should be valid" do
    @reservoir.should be_valid
  end
end
