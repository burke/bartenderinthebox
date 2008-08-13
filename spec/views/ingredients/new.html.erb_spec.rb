require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/new.html.erb" do
  include IngredientsHelper
  
  before(:each) do
    @ingredient = mock_model(Ingredient)
    @ingredient.stub!(:new_record?).and_return(true)
    @ingredient.stub!(:name).and_return("MyString")
    @ingredient.stub!(:percentage).and_return("1")
    assigns[:ingredient] = @ingredient
  end

  it "should render new form" do
    render "/ingredients/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", ingredients_path) do
      with_tag("input#ingredient_name[name=?]", "ingredient[name]")
      with_tag("input#ingredient_percentage[name=?]", "ingredient[percentage]")
    end
  end
end


