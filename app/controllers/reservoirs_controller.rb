class ReservoirsController < ApplicationController
  # GET /reservoirs
  # GET /reservoirs.xml
  def index
    @reservoirs = Reservoir.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reservoirs }
    end
  end

  # GET /reservoirs/1
  # GET /reservoirs/1.xml
  def show
    @reservoir = Reservoir.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservoir }
    end
  end

  # GET /reservoirs/new
  # GET /reservoirs/new.xml
  def new
    @reservoir = Reservoir.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservoir }
    end
  end

  # GET /reservoirs/1/edit
  def edit
    @reservoir = Reservoir.find(params[:id])
  end

  # POST /reservoirs
  # POST /reservoirs.xml
  def create
    @reservoir = Reservoir.new(params[:reservoir])

    respond_to do |format|
      if @reservoir.save
        flash[:notice] = 'Reservoir was successfully created.'
        format.html { redirect_to(@reservoir) }
        format.xml  { render :xml => @reservoir, :status => :created, :location => @reservoir }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reservoir.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reservoirs/1
  # PUT /reservoirs/1.xml
  def update
    @reservoir = Reservoir.find(params[:id])

    respond_to do |format|
      if @reservoir.update_attributes(params[:reservoir])
        flash[:notice] = 'Reservoir was successfully updated.'
        format.html { redirect_to(@reservoir) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservoir.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservoirs/1
  # DELETE /reservoirs/1.xml
  def destroy
    @reservoir = Reservoir.find(params[:id])
    @reservoir.destroy

    respond_to do |format|
      format.html { redirect_to(reservoirs_url) }
      format.xml  { head :ok }
    end
  end
end
