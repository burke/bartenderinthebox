require File.dirname(__FILE__) + '/../../spec_helper'

describe "/reservoirs/show.html.erb" do
  include ReservoirsHelper
  
  before(:each) do
    @reservoir = mock_model(Reservoir)
    @reservoir.stub!(:ingredient_id).and_return("1")
    @reservoir.stub!(:bay).and_return("1")

    assigns[:reservoir] = @reservoir
  end

  it "should render attributes in <p>" do
    render "/reservoirs/show.html.erb"
    response.should have_text(/1/)
  end
end

