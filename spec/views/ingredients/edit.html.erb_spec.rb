require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/edit.html.erb" do
  include IngredientsHelper
  
  before do
    @ingredient = mock_model(Ingredient)
    @ingredient.stub!(:name).and_return("MyString")
    @ingredient.stub!(:percentage).and_return("1")
    assigns[:ingredient] = @ingredient
  end

  it "should render edit form" do
    render "/ingredients/edit.html.erb"
    
    response.should have_tag("form[action=#{ingredient_path(@ingredient)}][method=post]") do
      with_tag('input#ingredient_name[name=?]', "ingredient[name]")
      with_tag('input#ingredient_percentage[name=?]', "ingredient[percentage]")
    end
  end
end


