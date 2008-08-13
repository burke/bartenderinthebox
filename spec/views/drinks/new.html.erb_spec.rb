require File.dirname(__FILE__) + '/../../spec_helper'

describe "/drinks/new.html.erb" do
  include DrinksHelper
  
  before(:each) do
    @drink = mock_model(Drink)
    @drink.stub!(:new_record?).and_return(true)
    @drink.stub!(:name).and_return("MyString")
    assigns[:drink] = @drink
  end

  it "should render new form" do
    render "/drinks/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", drinks_path) do
      with_tag("input#drink_name[name=?]", "drink[name]")
    end
  end
end


