# Be sure to restart your server when you modify this file

# my heroku.com app:
#Created http://morning-sky-26.heroku.com/ | git@heroku.com:morning-sky-26.git


# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

  #https://gist.github.com/807008
  #http://www.redmine.org/issues/7516#note-3
	#added this to config/environment.rb
	  # after
	  # Bootstrap the Rails environment, frameworks, and default configuration
    #  require File.join(File.dirname(__FILE__), 'boot')
	if Gem::VERSION >= "1.3.6" 
	  module Rails
	    class GemDependency
	      def requirement
	        r = super
	        (r == Gem::Requirement.default) ? nil : r
	      end
      end
    end
	end

Rails::Initializer.run do |config|
  
  # This is for gem-bundler to find all our gems
  #require 'vendor/bundler_gems/environment.rb' # add dependenceies to load paths
  #Bundler.require_env :optional_environment    # actually require the files

  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
  
  config.gem 'haml'
  config.gem 'andand'
  config.gem 'authlogic'
  
  #config.gem 'mime-types', :lib => 'mime/types'
  #config.gem 'daemons'
  

  config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'
  
  config.gem 'mislav-will_paginate', :version => '>= 2.3.8', :lib => 'will_paginate', 
             :source => 'http://gems.github.com'
  
  config.active_record.default_timezone = :utc

  config.action_controller.session = {
    :session_key => '_handsofhope_inventory_session',
    :secret      => 'a2914bf546b4dedb5778d6088e9209d39394c62d1fee243bfc1ef481af2a5cc089bc0cb9e7f28c1c40392fd3ecf428fa3d0feb4070c7e6dac1d4be3b3ef8b9a9'
  }
  
  config.time_zone = "Central Time (US & Canada)"

  config.gem "calendar_date_select"
  #ENV['TZ'] = 'UTC'  # what exactly does this do? I think it's needed for rails to retrieve the db values as UTC

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de



end
