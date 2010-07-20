ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "mekosam.com",
  :authentication => :plain,
  :user_name => "no-reply@mekosam.com",
  :password => "confirm12ab"
}