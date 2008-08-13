require File.dirname(__FILE__) + '/../spec_helper'

describe Drink do
  before(:each) do
    @drink = Drink.new
  end

  it "should be valid" do
    @drink.should be_valid
  end
end
