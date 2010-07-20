class UsersController < ApplicationController
  
  # Protect these actions behind an admin login
  before_filter :admin_required, :only => [:suspend, :unsuspend, :purge]

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate!
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end

  def suspend
    @user.suspend! 
    redirect_to users_path
  end

  def unsuspend
    @user.unsuspend! 
    redirect_to users_path
  end

  def destroy
    current_user.delete!    
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "Your profile has been successfully deleted."
    redirect_back_or_default('/')
  end

  def purge
    @user.destroy
    redirect_to users_path
  end
  
  def account
    if logged_in?
      @user = current_user
    else
      flash[:error] = 'You are not logged in - please login first'
      redirect_to "/login"
    end
  end
  
  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = "Profile updated successfully"
        format.html { redirect_to :action => "account" }
        format.xml  { head :ok }
      else
        format.html { render :action => "account" }
        format.xml  { render :xml => current_user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # action to perform when the user wants to change their password
  def change_password
    return unless request.post?
    if User.authenticate(current_user.login, params[:old_password])
      if (params[:password] == params[:password_confirmation])
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]
        if current_user.save
          flash[:notice] = "Password updated successfully"
        else
          flash[:error] = "Password not changed"
        end
      else
        flash[:error] = "New password mismatch"
        @old_password = params[:old_password]
      end
    else
      flash[:error] = "Old password incorrect"
    end
    redirect_to account_url
  end

  # action to perform when the users clicks forgot_password
  def forgot_password
    return unless request.post?
    if @user = User.find_by_email(params[:email])
      @user.forgot_password
      @user.save
      redirect_back_or_default('/')
      flash[:notice] = "A password reset link has been sent to your email address: #{params[:email]}"
    else
      flash[:alert] = "Could not find a user with that email address: #{params[:email]}"
    end
  end

  # action to perform when the user resets the password
  def reset_password
    @user = User.find_by_password_reset_code(params[:code])
    return if @user unless params[:user]

    if ((params[:user][:password] && params[:user][:password_confirmation]))
      self.current_user = @user # for the next two lines to work
      current_user.password_confirmation = params[:user][:password_confirmation]
      current_user.password = params[:user][:password]
      @user.reset_password
      flash[:notice] = current_user.save ? "Password reset successfully" : "Unable to reset password"
      redirect_back_or_default('/')
    else
      flash[:alert] = "Password mismatch"
    end
  end  

protected
  def find_user
    @user = User.find(params[:id])
  end

end
