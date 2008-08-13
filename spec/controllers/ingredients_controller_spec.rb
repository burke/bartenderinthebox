require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientsController do
  describe "handling GET /ingredients" do

    before(:each) do
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:find).and_return([@ingredient])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all ingredients" do
      Ingredient.should_receive(:find).with(:all).and_return([@ingredient])
      do_get
    end
  
    it "should assign the found ingredients for the view" do
      do_get
      assigns[:ingredients].should == [@ingredient]
    end
  end

  describe "handling GET /ingredients.xml" do

    before(:each) do
      @ingredient = mock_model(Ingredient, :to_xml => "XML")
      Ingredient.stub!(:find).and_return(@ingredient)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all ingredients" do
      Ingredient.should_receive(:find).with(:all).and_return([@ingredient])
      do_get
    end
  
    it "should render the found ingredients as xml" do
      @ingredient.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /ingredients/1" do

    before(:each) do
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:find).and_return(@ingredient)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the ingredient requested" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
  
    it "should assign the found ingredient for the view" do
      do_get
      assigns[:ingredient].should equal(@ingredient)
    end
  end

  describe "handling GET /ingredients/1.xml" do

    before(:each) do
      @ingredient = mock_model(Ingredient, :to_xml => "XML")
      Ingredient.stub!(:find).and_return(@ingredient)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the ingredient requested" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
  
    it "should render the found ingredient as xml" do
      @ingredient.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /ingredients/new" do

    before(:each) do
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:new).and_return(@ingredient)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new ingredient" do
      Ingredient.should_receive(:new).and_return(@ingredient)
      do_get
    end
  
    it "should not save the new ingredient" do
      @ingredient.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new ingredient for the view" do
      do_get
      assigns[:ingredient].should equal(@ingredient)
    end
  end

  describe "handling GET /ingredients/1/edit" do

    before(:each) do
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:find).and_return(@ingredient)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the ingredient requested" do
      Ingredient.should_receive(:find).and_return(@ingredient)
      do_get
    end
  
    it "should assign the found Ingredient for the view" do
      do_get
      assigns[:ingredient].should equal(@ingredient)
    end
  end

  describe "handling POST /ingredients" do

    before(:each) do
      @ingredient = mock_model(Ingredient, :to_param => "1")
      Ingredient.stub!(:new).and_return(@ingredient)
    end
    
    describe "with successful save" do
  
      def do_post
        @ingredient.should_receive(:save).and_return(true)
        post :create, :ingredient => {}
      end
  
      it "should create a new ingredient" do
        Ingredient.should_receive(:new).with({}).and_return(@ingredient)
        do_post
      end

      it "should redirect to the new ingredient" do
        do_post
        response.should redirect_to(ingredient_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @ingredient.should_receive(:save).and_return(false)
        post :create, :ingredient => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /ingredients/1" do

    before(:each) do
      @ingredient = mock_model(Ingredient, :to_param => "1")
      Ingredient.stub!(:find).and_return(@ingredient)
    end
    
    describe "with successful update" do

      def do_put
        @ingredient.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the ingredient requested" do
        Ingredient.should_receive(:find).with("1").and_return(@ingredient)
        do_put
      end

      it "should update the found ingredient" do
        do_put
        assigns(:ingredient).should equal(@ingredient)
      end

      it "should assign the found ingredient for the view" do
        do_put
        assigns(:ingredient).should equal(@ingredient)
      end

      it "should redirect to the ingredient" do
        do_put
        response.should redirect_to(ingredient_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @ingredient.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /ingredients/1" do

    before(:each) do
      @ingredient = mock_model(Ingredient, :destroy => true)
      Ingredient.stub!(:find).and_return(@ingredient)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the ingredient requested" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_delete
    end
  
    it "should call destroy on the found ingredient" do
      @ingredient.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the ingredients list" do
      do_delete
      response.should redirect_to(ingredients_url)
    end
  end
end