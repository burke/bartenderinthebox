require File.dirname(__FILE__) + '/../../spec_helper'

describe "/reservoirs/index.html.erb" do
  include ReservoirsHelper
  
  before(:each) do
    reservoir_98 = mock_model(Reservoir)
    reservoir_98.should_receive(:ingredient_id).and_return("1")
    reservoir_98.should_receive(:bay).and_return("1")
    reservoir_99 = mock_model(Reservoir)
    reservoir_99.should_receive(:ingredient_id).and_return("1")
    reservoir_99.should_receive(:bay).and_return("1")

    assigns[:reservoirs] = [reservoir_98, reservoir_99]
  end

  it "should render list of reservoirs" do
    render "/reservoirs/index.html.erb"
    response.should have_tag("tr>td", "1", 2)
  end
end

