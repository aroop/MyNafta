RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.action_controller.session = {
    :session_key => '_nafta_session',
    :secret      => '30fa2e5e447103295d48c41309600c37455226f0ad8be7c69f1946ec51adfca6108a63c33ca3a514adb5b96b7f4175014f748f645789046fa6e25cb24ed479ee'
  }
  config.active_record.observers = :user_observer
end