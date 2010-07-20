class PartDetailArchivesController < ApplicationController
  # GET /part_detail_archives
  # GET /part_detail_archives.xml
  def index
    @part_detail_archives = PartDetailArchive.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @part_detail_archives }
    end
  end

  # GET /part_detail_archives/1
  # GET /part_detail_archives/1.xml
  def show
    @part_detail_archive = PartDetailArchive.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @part_detail_archive }
    end
  end

  # GET /part_detail_archives/new
  # GET /part_detail_archives/new.xml
  def new
    @part_detail_archive = PartDetailArchive.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @part_detail_archive }
    end
  end

  # GET /part_detail_archives/1/edit
  def edit
    @part_detail_archive = PartDetailArchive.find(params[:id])
  end

  # POST /part_detail_archives
  # POST /part_detail_archives.xml
  def create
    @part_detail_archive = PartDetailArchive.new(params[:part_detail_archive])

    respond_to do |format|
      if @part_detail_archive.save
        flash[:notice] = 'PartDetailArchive was successfully created.'
        format.html { redirect_to(@part_detail_archive) }
        format.xml  { render :xml => @part_detail_archive, :status => :created, :location => @part_detail_archive }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @part_detail_archive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /part_detail_archives/1
  # PUT /part_detail_archives/1.xml
  def update
    @part_detail_archive = PartDetailArchive.find(params[:id])

    respond_to do |format|
      if @part_detail_archive.update_attributes(params[:part_detail_archive])
        flash[:notice] = 'PartDetailArchive was successfully updated.'
        format.html { redirect_to(@part_detail_archive) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @part_detail_archive.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /part_detail_archives/1
  # DELETE /part_detail_archives/1.xml
  def destroy
    @part_detail_archive = PartDetailArchive.find(params[:id])
    @part_detail_archive.destroy

    respond_to do |format|
      format.html { redirect_to(part_detail_archives_url) }
      format.xml  { head :ok }
    end
  end
end
