require File.dirname(__FILE__) + '/../../spec_helper'

describe "/drinks/edit.html.erb" do
  include DrinksHelper
  
  before do
    @drink = mock_model(Drink)
    @drink.stub!(:name).and_return("MyString")
    assigns[:drink] = @drink
  end

  it "should render edit form" do
    render "/drinks/edit.html.erb"
    
    response.should have_tag("form[action=#{drink_path(@drink)}][method=post]") do
      with_tag('input#drink_name[name=?]', "drink[name]")
    end
  end
end


