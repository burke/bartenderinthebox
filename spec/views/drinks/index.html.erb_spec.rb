require File.dirname(__FILE__) + '/../../spec_helper'

describe "/drinks/index.html.erb" do
  include DrinksHelper
  
  before(:each) do
    drink_98 = mock_model(Drink)
    drink_98.should_receive(:name).and_return("MyString")
    drink_99 = mock_model(Drink)
    drink_99.should_receive(:name).and_return("MyString")

    assigns[:drinks] = [drink_98, drink_99]
  end

  it "should render list of drinks" do
    render "/drinks/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

