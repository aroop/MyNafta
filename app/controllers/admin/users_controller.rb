class Admin::UsersController < ApplicationController

  before_filter :admin_required

  def suspend
    @user.suspend!
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend!
    redirect_to users_path
  end

  def purge
    @user.destroy
    redirect_to users_path
  end

  # GET /admin_users
  # GET /admin_users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin_users/1
  # GET /admin_users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin_users/new
  # GET /admin_users/new.xml
  def new
    @user = User.new
    @addresses = []
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /admin_users/1/edit
  def edit
    @user = User.find(params[:id])
    @addresses = []
    @user.addresses.each do |address|
      @addresses << address.id
    end
  end

  # POST /admin_users
  # POST /admin_users.xml
  def create
    @user = User.new(params[:user])
    @user.role = Role.find(params[:user][:role_id])
    @user.register! if @user.valid?
    respond_to do |format|
      if @user.errors.empty?

        @user.user_assignments.each { |assignment| assignment.destroy! }
        params[:supplier][:id].each { |supplier_id| @user.user_assignments.create(:address => Address.find(supplier_id)) }
        params[:importer][:id].each { |importer_id| @user.user_assignments.create(:address => Address.find(importer_id)) }

        flash[:notice] = 'User was successfully created. A mail has been sent to the newly created user.'
        format.html { redirect_to(admin_users_path) }
        format.xml  { render :xml => @user, :status => :created, :location => @users }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_users/1
  # PUT /admin_users/1.xml
  def update
    @user = User.find(params[:id])
    @user.role = Role.find(params[:user][:role_id])
    respond_to do |format|
      if @user.update_attributes(params[:user])
        puts "---------------------------------"
        puts "In update"
        puts "---------------------------------"
        @user.user_assignments.each { |assignment| assignment.destroy }
        params[:supplier][:id].each { |supplier_id| @user.user_assignments.create(:address => Address.find(supplier_id)) } unless params[:supplier].blank?
        params[:importer][:id].each { |importer_id| @user.user_assignments.create(:address => Address.find(importer_id)) } unless params[:importer].blank?

        flash[:notice] = 'Users was successfully updated.'
        format.html { redirect_to(admin_users_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_users/1
  # DELETE /admin_users/1.xml
  def destroy
    @users = User.find(params[:id])
    @users.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end

  protected
  def find_user
    @user = User.find(params[:id])
  end


end