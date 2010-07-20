class PartDetailsController < ApplicationController
  # GET /part_details
  # GET /part_details.xml
  def index
    @part_details = PartDetail.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @part_details }
    end
  end

  # GET /part_details/1
  # GET /part_details/1.xml
  def show
    @part_detail = PartDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @part_detail }
    end
  end

  # GET /part_details/new
  # GET /part_details/new.xml
  def new
    @part_detail = PartDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @part_detail }
    end
  end

  # GET /part_details/1/edit
  def edit
    @part_detail = PartDetail.find(params[:id])
  end

  # POST /part_details
  # POST /part_details.xml
  def create
    @part_detail = PartDetail.new(params[:part_detail])

    respond_to do |format|
      if @part_detail.save
        flash[:notice] = 'PartDetail was successfully created.'
        format.html { redirect_to(@part_detail) }
        format.xml  { render :xml => @part_detail, :status => :created, :location => @part_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @part_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /part_details/1
  # PUT /part_details/1.xml
  def update
    @part_detail = PartDetail.find(params[:id])

    respond_to do |format|
      if @part_detail.update_attributes(params[:part_detail])
        flash[:notice] = 'PartDetail was successfully updated.'
        format.html { redirect_to(:controller => 'home', :action => 'search') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @part_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /part_details/1
  # DELETE /part_details/1.xml
  def destroy
    @part_detail = PartDetail.find(params[:id])
    @part_detail.destroy

    respond_to do |format|
      format.html { redirect_to(part_details_url) }
      format.xml  { head :ok }
    end
  end
end
