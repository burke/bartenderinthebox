require File.dirname(__FILE__) + '/../../spec_helper'

describe "/drinks/show.html.erb" do
  include DrinksHelper
  
  before(:each) do
    @drink = mock_model(Drink)
    @drink.stub!(:name).and_return("MyString")

    assigns[:drink] = @drink
  end

  it "should render attributes in <p>" do
    render "/drinks/show.html.erb"
    response.should have_text(/MyString/)
  end
end

