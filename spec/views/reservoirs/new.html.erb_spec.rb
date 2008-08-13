require File.dirname(__FILE__) + '/../../spec_helper'

describe "/reservoirs/new.html.erb" do
  include ReservoirsHelper
  
  before(:each) do
    @reservoir = mock_model(Reservoir)
    @reservoir.stub!(:new_record?).and_return(true)
    @reservoir.stub!(:ingredient_id).and_return("1")
    @reservoir.stub!(:bay).and_return("1")
    assigns[:reservoir] = @reservoir
  end

  it "should render new form" do
    render "/reservoirs/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", reservoirs_path) do
      with_tag("input#reservoir_bay[name=?]", "reservoir[bay]")
    end
  end
end


