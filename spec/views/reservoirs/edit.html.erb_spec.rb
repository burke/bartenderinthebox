require File.dirname(__FILE__) + '/../../spec_helper'

describe "/reservoirs/edit.html.erb" do
  include ReservoirsHelper
  
  before do
    @reservoir = mock_model(Reservoir)
    @reservoir.stub!(:ingredient_id).and_return("1")
    @reservoir.stub!(:bay).and_return("1")
    assigns[:reservoir] = @reservoir
  end

  it "should render edit form" do
    render "/reservoirs/edit.html.erb"
    
    response.should have_tag("form[action=#{reservoir_path(@reservoir)}][method=post]") do
      with_tag('input#reservoir_bay[name=?]', "reservoir[bay]")
    end
  end
end


