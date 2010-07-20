class ApplicationController < ActionController::Base
  helper :all

  protect_from_forgery # :secret => 'f2278c880921f87504dd60519931f125'

  include AuthenticatedSystem

  protected
  # Protect controllers with code like:
  # before_filter :admin_required, :only => [:suspend, :unsuspend, :destroy, :purge]
  def admin_required
    (logged_in? && current_user.role == Role.find_by_name('Admin')) || admin_denied
  end

  def admin_denied
    respond_to do |format|
      format.html do
        store_location
        flash[:error] = 'You do not have the required role to do this action. Please login with the admin role.'
        redirect_to new_session_path
      end
    end
  end

  def supplier_required
    (logged_in? && (current_user.role == Role.find_by_name('Supplier') || current_user.role == Role.find_by_name('Admin'))) || supplier_denied
  end

  def supplier_denied
    respond_to do |format|
      format.html do
        store_location
        flash[:error] = 'You do not have the required role to do this action. Please login with the supplier role.'
        redirect_to new_session_path
      end
    end
  end

end