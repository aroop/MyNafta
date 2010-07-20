class UserMailer < ActionMailer::Base


  def signup_notification(user)
    setup_email(user,'Please activate your new account')
    @body[:url]  = "www.naftaapp.com/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user,'Your account has been activated!')
    @body[:url]  = "www.naftaapp.com/"
  end

  def forgot_password(user)
    setup_email(user,'You have requested to change your password')
    @body[:url]  = "www.naftaapp.com/reset_password/#{user.password_reset_code}"
  end

  def reset_password(user)
    setup_email(user,'Your password has been reset.')
  end

  protected

  def setup_email(user,subj=nil)
    recipients  "#{user.email}"
    from        %{"Nafta" <no-reply@naftaapp.com>}
    subject     "[www.naftaapp.com] #{subj}"
    sent_on     Time.now
    body        :user => user 
  end
  
end