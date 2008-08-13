require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/show.html.erb" do
  include IngredientsHelper
  
  before(:each) do
    @ingredient = mock_model(Ingredient)
    @ingredient.stub!(:name).and_return("MyString")
    @ingredient.stub!(:percentage).and_return("1")

    assigns[:ingredient] = @ingredient
  end

  it "should render attributes in <p>" do
    render "/ingredients/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/1/)
  end
end

