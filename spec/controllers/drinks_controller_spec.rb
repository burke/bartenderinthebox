require File.dirname(__FILE__) + '/../spec_helper'

describe DrinksController do
  describe "handling GET /drinks" do

    before(:each) do
      @drink = mock_model(Drink)
      Drink.stub!(:find).and_return([@drink])
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
  
    it "should find all drinks" do
      Drink.should_receive(:find).with(:all).and_return([@drink])
      do_get
    end
  
    it "should assign the found drinks for the view" do
      do_get
      assigns[:drinks].should == [@drink]
    end
  end

  describe "handling GET /drinks.xml" do

    before(:each) do
      @drink = mock_model(Drink, :to_xml => "XML")
      Drink.stub!(:find).and_return(@drink)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all drinks" do
      Drink.should_receive(:find).with(:all).and_return([@drink])
      do_get
    end
  
    it "should render the found drinks as xml" do
      @drink.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /drinks/1" do

    before(:each) do
      @drink = mock_model(Drink)
      Drink.stub!(:find).and_return(@drink)
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
  
    it "should find the drink requested" do
      Drink.should_receive(:find).with("1").and_return(@drink)
      do_get
    end
  
    it "should assign the found drink for the view" do
      do_get
      assigns[:drink].should equal(@drink)
    end
  end

  describe "handling GET /drinks/1.xml" do

    before(:each) do
      @drink = mock_model(Drink, :to_xml => "XML")
      Drink.stub!(:find).and_return(@drink)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the drink requested" do
      Drink.should_receive(:find).with("1").and_return(@drink)
      do_get
    end
  
    it "should render the found drink as xml" do
      @drink.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /drinks/new" do

    before(:each) do
      @drink = mock_model(Drink)
      Drink.stub!(:new).and_return(@drink)
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
  
    it "should create an new drink" do
      Drink.should_receive(:new).and_return(@drink)
      do_get
    end
  
    it "should not save the new drink" do
      @drink.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new drink for the view" do
      do_get
      assigns[:drink].should equal(@drink)
    end
  end

  describe "handling GET /drinks/1/edit" do

    before(:each) do
      @drink = mock_model(Drink)
      Drink.stub!(:find).and_return(@drink)
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
  
    it "should find the drink requested" do
      Drink.should_receive(:find).and_return(@drink)
      do_get
    end
  
    it "should assign the found Drink for the view" do
      do_get
      assigns[:drink].should equal(@drink)
    end
  end

  describe "handling POST /drinks" do

    before(:each) do
      @drink = mock_model(Drink, :to_param => "1")
      Drink.stub!(:new).and_return(@drink)
    end
    
    describe "with successful save" do
  
      def do_post
        @drink.should_receive(:save).and_return(true)
        post :create, :drink => {}
      end
  
      it "should create a new drink" do
        Drink.should_receive(:new).with({}).and_return(@drink)
        do_post
      end

      it "should redirect to the new drink" do
        do_post
        response.should redirect_to(drink_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @drink.should_receive(:save).and_return(false)
        post :create, :drink => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /drinks/1" do

    before(:each) do
      @drink = mock_model(Drink, :to_param => "1")
      Drink.stub!(:find).and_return(@drink)
    end
    
    describe "with successful update" do

      def do_put
        @drink.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the drink requested" do
        Drink.should_receive(:find).with("1").and_return(@drink)
        do_put
      end

      it "should update the found drink" do
        do_put
        assigns(:drink).should equal(@drink)
      end

      it "should assign the found drink for the view" do
        do_put
        assigns(:drink).should equal(@drink)
      end

      it "should redirect to the drink" do
        do_put
        response.should redirect_to(drink_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @drink.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /drinks/1" do

    before(:each) do
      @drink = mock_model(Drink, :destroy => true)
      Drink.stub!(:find).and_return(@drink)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the drink requested" do
      Drink.should_receive(:find).with("1").and_return(@drink)
      do_delete
    end
  
    it "should call destroy on the found drink" do
      @drink.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the drinks list" do
      do_delete
      response.should redirect_to(drinks_url)
    end
  end
end