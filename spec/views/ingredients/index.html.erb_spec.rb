require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/index.html.erb" do
  include IngredientsHelper
  
  before(:each) do
    ingredient_98 = mock_model(Ingredient)
    ingredient_98.should_receive(:name).and_return("MyString")
    ingredient_98.should_receive(:percentage).and_return("1")
    ingredient_99 = mock_model(Ingredient)
    ingredient_99.should_receive(:name).and_return("MyString")
    ingredient_99.should_receive(:percentage).and_return("1")

    assigns[:ingredients] = [ingredient_98, ingredient_99]
  end

  it "should render list of ingredients" do
    render "/ingredients/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

