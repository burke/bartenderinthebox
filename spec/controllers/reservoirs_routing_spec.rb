require File.dirname(__FILE__) + '/../spec_helper'

describe ReservoirsController do
  describe "route generation" do

    it "should map { :controller => 'reservoirs', :action => 'index' } to /reservoirs" do
      route_for(:controller => "reservoirs", :action => "index").should == "/reservoirs"
    end
  
    it "should map { :controller => 'reservoirs', :action => 'new' } to /reservoirs/new" do
      route_for(:controller => "reservoirs", :action => "new").should == "/reservoirs/new"
    end
  
    it "should map { :controller => 'reservoirs', :action => 'show', :id => 1 } to /reservoirs/1" do
      route_for(:controller => "reservoirs", :action => "show", :id => 1).should == "/reservoirs/1"
    end
  
    it "should map { :controller => 'reservoirs', :action => 'edit', :id => 1 } to /reservoirs/1/edit" do
      route_for(:controller => "reservoirs", :action => "edit", :id => 1).should == "/reservoirs/1/edit"
    end
  
    it "should map { :controller => 'reservoirs', :action => 'update', :id => 1} to /reservoirs/1" do
      route_for(:controller => "reservoirs", :action => "update", :id => 1).should == "/reservoirs/1"
    end
  
    it "should map { :controller => 'reservoirs', :action => 'destroy', :id => 1} to /reservoirs/1" do
      route_for(:controller => "reservoirs", :action => "destroy", :id => 1).should == "/reservoirs/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'reservoirs', action => 'index' } from GET /reservoirs" do
      params_from(:get, "/reservoirs").should == {:controller => "reservoirs", :action => "index"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'new' } from GET /reservoirs/new" do
      params_from(:get, "/reservoirs/new").should == {:controller => "reservoirs", :action => "new"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'create' } from POST /reservoirs" do
      params_from(:post, "/reservoirs").should == {:controller => "reservoirs", :action => "create"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'show', id => '1' } from GET /reservoirs/1" do
      params_from(:get, "/reservoirs/1").should == {:controller => "reservoirs", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'edit', id => '1' } from GET /reservoirs/1;edit" do
      params_from(:get, "/reservoirs/1/edit").should == {:controller => "reservoirs", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'update', id => '1' } from PUT /reservoirs/1" do
      params_from(:put, "/reservoirs/1").should == {:controller => "reservoirs", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'reservoirs', action => 'destroy', id => '1' } from DELETE /reservoirs/1" do
      params_from(:delete, "/reservoirs/1").should == {:controller => "reservoirs", :action => "destroy", :id => "1"}
    end
  end
end