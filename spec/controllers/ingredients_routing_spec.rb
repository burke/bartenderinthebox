require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientsController do
  describe "route generation" do

    it "should map { :controller => 'ingredients', :action => 'index' } to /ingredients" do
      route_for(:controller => "ingredients", :action => "index").should == "/ingredients"
    end
  
    it "should map { :controller => 'ingredients', :action => 'new' } to /ingredients/new" do
      route_for(:controller => "ingredients", :action => "new").should == "/ingredients/new"
    end
  
    it "should map { :controller => 'ingredients', :action => 'show', :id => 1 } to /ingredients/1" do
      route_for(:controller => "ingredients", :action => "show", :id => 1).should == "/ingredients/1"
    end
  
    it "should map { :controller => 'ingredients', :action => 'edit', :id => 1 } to /ingredients/1/edit" do
      route_for(:controller => "ingredients", :action => "edit", :id => 1).should == "/ingredients/1/edit"
    end
  
    it "should map { :controller => 'ingredients', :action => 'update', :id => 1} to /ingredients/1" do
      route_for(:controller => "ingredients", :action => "update", :id => 1).should == "/ingredients/1"
    end
  
    it "should map { :controller => 'ingredients', :action => 'destroy', :id => 1} to /ingredients/1" do
      route_for(:controller => "ingredients", :action => "destroy", :id => 1).should == "/ingredients/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'ingredients', action => 'index' } from GET /ingredients" do
      params_from(:get, "/ingredients").should == {:controller => "ingredients", :action => "index"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'new' } from GET /ingredients/new" do
      params_from(:get, "/ingredients/new").should == {:controller => "ingredients", :action => "new"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'create' } from POST /ingredients" do
      params_from(:post, "/ingredients").should == {:controller => "ingredients", :action => "create"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'show', id => '1' } from GET /ingredients/1" do
      params_from(:get, "/ingredients/1").should == {:controller => "ingredients", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'edit', id => '1' } from GET /ingredients/1;edit" do
      params_from(:get, "/ingredients/1/edit").should == {:controller => "ingredients", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'update', id => '1' } from PUT /ingredients/1" do
      params_from(:put, "/ingredients/1").should == {:controller => "ingredients", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'ingredients', action => 'destroy', id => '1' } from DELETE /ingredients/1" do
      params_from(:delete, "/ingredients/1").should == {:controller => "ingredients", :action => "destroy", :id => "1"}
    end
  end
end