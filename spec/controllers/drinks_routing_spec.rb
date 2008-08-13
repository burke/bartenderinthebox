require File.dirname(__FILE__) + '/../spec_helper'

describe DrinksController do
  describe "route generation" do

    it "should map { :controller => 'drinks', :action => 'index' } to /drinks" do
      route_for(:controller => "drinks", :action => "index").should == "/drinks"
    end
  
    it "should map { :controller => 'drinks', :action => 'new' } to /drinks/new" do
      route_for(:controller => "drinks", :action => "new").should == "/drinks/new"
    end
  
    it "should map { :controller => 'drinks', :action => 'show', :id => 1 } to /drinks/1" do
      route_for(:controller => "drinks", :action => "show", :id => 1).should == "/drinks/1"
    end
  
    it "should map { :controller => 'drinks', :action => 'edit', :id => 1 } to /drinks/1/edit" do
      route_for(:controller => "drinks", :action => "edit", :id => 1).should == "/drinks/1/edit"
    end
  
    it "should map { :controller => 'drinks', :action => 'update', :id => 1} to /drinks/1" do
      route_for(:controller => "drinks", :action => "update", :id => 1).should == "/drinks/1"
    end
  
    it "should map { :controller => 'drinks', :action => 'destroy', :id => 1} to /drinks/1" do
      route_for(:controller => "drinks", :action => "destroy", :id => 1).should == "/drinks/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'drinks', action => 'index' } from GET /drinks" do
      params_from(:get, "/drinks").should == {:controller => "drinks", :action => "index"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'new' } from GET /drinks/new" do
      params_from(:get, "/drinks/new").should == {:controller => "drinks", :action => "new"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'create' } from POST /drinks" do
      params_from(:post, "/drinks").should == {:controller => "drinks", :action => "create"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'show', id => '1' } from GET /drinks/1" do
      params_from(:get, "/drinks/1").should == {:controller => "drinks", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'edit', id => '1' } from GET /drinks/1;edit" do
      params_from(:get, "/drinks/1/edit").should == {:controller => "drinks", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'update', id => '1' } from PUT /drinks/1" do
      params_from(:put, "/drinks/1").should == {:controller => "drinks", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'drinks', action => 'destroy', id => '1' } from DELETE /drinks/1" do
      params_from(:delete, "/drinks/1").should == {:controller => "drinks", :action => "destroy", :id => "1"}
    end
  end
end