require File.dirname(__FILE__) + '/../spec_helper'

describe Ingredient do
  before(:each) do
    @ingredient = Ingredient.new
  end

  it "should be valid" do
    @ingredient.should be_valid
  end
end
