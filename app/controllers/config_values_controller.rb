class ConfigValuesController < ApplicationController
  # GET /config_values
  # GET /config_values.xml
  def index
    @config_values = ConfigValue.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @config_values }
    end
  end

  # GET /config_values/1
  # GET /config_values/1.xml
  def show
    @config_value = ConfigValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @config_value }
    end
  end

  # GET /config_values/new
  # GET /config_values/new.xml
  def new
    @config_value = ConfigValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @config_value }
    end
  end

  # GET /config_values/1/edit
  def edit
    @config_value = ConfigValue.find(params[:id])
  end

  # POST /config_values
  # POST /config_values.xml
  def create
    @config_value = ConfigValue.new(params[:config_value])

    respond_to do |format|
      if @config_value.save
        flash[:notice] = 'ConfigValue was successfully created.'
        format.html { redirect_to(@config_value) }
        format.xml  { render :xml => @config_value, :status => :created, :location => @config_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @config_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /config_values/1
  # PUT /config_values/1.xml
  def update
    @config_value = ConfigValue.find(params[:id])

    respond_to do |format|
      if @config_value.update_attributes(params[:config_value])
        flash[:notice] = 'ConfigValue was successfully updated.'
        format.html { redirect_to(@config_value) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @config_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /config_values/1
  # DELETE /config_values/1.xml
  def destroy
    @config_value = ConfigValue.find(params[:id])
    @config_value.destroy

    respond_to do |format|
      format.html { redirect_to(config_values_url) }
      format.xml  { head :ok }
    end
  end
end
