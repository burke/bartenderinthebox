require File.dirname(__FILE__) + '/../spec_helper'

describe ReservoirsController do
  describe "handling GET /reservoirs" do

    before(:each) do
      @reservoir = mock_model(Reservoir)
      Reservoir.stub!(:find).and_return([@reservoir])
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
  
    it "should find all reservoirs" do
      Reservoir.should_receive(:find).with(:all).and_return([@reservoir])
      do_get
    end
  
    it "should assign the found reservoirs for the view" do
      do_get
      assigns[:reservoirs].should == [@reservoir]
    end
  end

  describe "handling GET /reservoirs.xml" do

    before(:each) do
      @reservoir = mock_model(Reservoir, :to_xml => "XML")
      Reservoir.stub!(:find).and_return(@reservoir)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all reservoirs" do
      Reservoir.should_receive(:find).with(:all).and_return([@reservoir])
      do_get
    end
  
    it "should render the found reservoirs as xml" do
      @reservoir.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /reservoirs/1" do

    before(:each) do
      @reservoir = mock_model(Reservoir)
      Reservoir.stub!(:find).and_return(@reservoir)
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
  
    it "should find the reservoir requested" do
      Reservoir.should_receive(:find).with("1").and_return(@reservoir)
      do_get
    end
  
    it "should assign the found reservoir for the view" do
      do_get
      assigns[:reservoir].should equal(@reservoir)
    end
  end

  describe "handling GET /reservoirs/1.xml" do

    before(:each) do
      @reservoir = mock_model(Reservoir, :to_xml => "XML")
      Reservoir.stub!(:find).and_return(@reservoir)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the reservoir requested" do
      Reservoir.should_receive(:find).with("1").and_return(@reservoir)
      do_get
    end
  
    it "should render the found reservoir as xml" do
      @reservoir.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /reservoirs/new" do

    before(:each) do
      @reservoir = mock_model(Reservoir)
      Reservoir.stub!(:new).and_return(@reservoir)
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
  
    it "should create an new reservoir" do
      Reservoir.should_receive(:new).and_return(@reservoir)
      do_get
    end
  
    it "should not save the new reservoir" do
      @reservoir.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new reservoir for the view" do
      do_get
      assigns[:reservoir].should equal(@reservoir)
    end
  end

  describe "handling GET /reservoirs/1/edit" do

    before(:each) do
      @reservoir = mock_model(Reservoir)
      Reservoir.stub!(:find).and_return(@reservoir)
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
  
    it "should find the reservoir requested" do
      Reservoir.should_receive(:find).and_return(@reservoir)
      do_get
    end
  
    it "should assign the found Reservoir for the view" do
      do_get
      assigns[:reservoir].should equal(@reservoir)
    end
  end

  describe "handling POST /reservoirs" do

    before(:each) do
      @reservoir = mock_model(Reservoir, :to_param => "1")
      Reservoir.stub!(:new).and_return(@reservoir)
    end
    
    describe "with successful save" do
  
      def do_post
        @reservoir.should_receive(:save).and_return(true)
        post :create, :reservoir => {}
      end
  
      it "should create a new reservoir" do
        Reservoir.should_receive(:new).with({}).and_return(@reservoir)
        do_post
      end

      it "should redirect to the new reservoir" do
        do_post
        response.should redirect_to(reservoir_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @reservoir.should_receive(:save).and_return(false)
        post :create, :reservoir => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /reservoirs/1" do

    before(:each) do
      @reservoir = mock_model(Reservoir, :to_param => "1")
      Reservoir.stub!(:find).and_return(@reservoir)
    end
    
    describe "with successful update" do

      def do_put
        @reservoir.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the reservoir requested" do
        Reservoir.should_receive(:find).with("1").and_return(@reservoir)
        do_put
      end

      it "should update the found reservoir" do
        do_put
        assigns(:reservoir).should equal(@reservoir)
      end

      it "should assign the found reservoir for the view" do
        do_put
        assigns(:reservoir).should equal(@reservoir)
      end

      it "should redirect to the reservoir" do
        do_put
        response.should redirect_to(reservoir_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @reservoir.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /reservoirs/1" do

    before(:each) do
      @reservoir = mock_model(Reservoir, :destroy => true)
      Reservoir.stub!(:find).and_return(@reservoir)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the reservoir requested" do
      Reservoir.should_receive(:find).with("1").and_return(@reservoir)
      do_delete
    end
  
    it "should call destroy on the found reservoir" do
      @reservoir.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the reservoirs list" do
      do_delete
      response.should redirect_to(reservoirs_url)
    end
  end
end