class CertifiedRepositoriesController < ApplicationController
  # GET /certified_repositories
  # GET /certified_repositories.xml
  def index
    @certified_repositories = CertifiedRepository.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @certified_repositories }
    end
  end

  # GET /certified_repositories/1
  # GET /certified_repositories/1.xml
  def show
    @certified_repository = CertifiedRepository.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @certified_repository }
    end
  end

  # GET /certified_repositories/new
  # GET /certified_repositories/new.xml
  def new
    @certified_repository = CertifiedRepository.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @certified_repository }
    end
  end

  # GET /certified_repositories/1/edit
  def edit
    @certified_repository = CertifiedRepository.find(params[:id])
  end

  # POST /certified_repositories
  # POST /certified_repositories.xml
  def create
    @certified_repository = CertifiedRepository.new(params[:certified_repository])

    respond_to do |format|
      if @certified_repository.save
        flash[:notice] = 'CertifiedRepository was successfully created.'
        format.html { redirect_to(@certified_repository) }
        format.xml  { render :xml => @certified_repository, :status => :created, :location => @certified_repository }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @certified_repository.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /certified_repositories/1
  # PUT /certified_repositories/1.xml
  def update
    @certified_repository = CertifiedRepository.find(params[:id])

    respond_to do |format|
      if @certified_repository.update_attributes(params[:certified_repository])
        flash[:notice] = 'CertifiedRepository was successfully updated.'
        format.html { redirect_to(@certified_repository) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @certified_repository.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /certified_repositories/1
  # DELETE /certified_repositories/1.xml
  def destroy
    @certified_repository = CertifiedRepository.find(params[:id])
    @certified_repository.destroy

    respond_to do |format|
      format.html { redirect_to(certified_repositories_url) }
      format.xml  { head :ok }
    end
  end
end
