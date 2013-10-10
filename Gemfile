source 'https://rubygems.org'

gem "rails", "2.3.8"
gem "rack", "~> 1.1.0"

gem "inherited_resources", "= 1.0.6"
gem "will_paginate", "~> 2.3.11"
gem "SyslogLogger"
gem "delayed_job", "= 2.0.4"
gem "metalive", "0.0.1"

gem "tryphon-box", :git => "git://projects.tryphon.priv/box"

group :development do
  gem "sqlite3-ruby"
  gem "ZenTest"
  gem "rake-debian-build"
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  # gem 'guard-cucumber'
  gem 'libnotify' if RUBY_PLATFORM =~ /linux/
  gem 'capistrano'
  gem 'capistrano-ext'
end

group :test do
  gem 'rspec', '< 2.0'
  gem 'rspec-rails', '< 2.0'
  gem 'remarkable_rails'
  gem 'rcov'

  gem 'taglib-ruby'
end

# group :cucumber do
#   gem 'capybara'
#   gem 'database_cleaner'
#   gem 'cucumber-rails'
#   gem 'cucumber'
#   gem 'rspec-rails', '< 2.0'
#   gem 'pickle'
#   gem 'factory_girl'

#   # used by features/support/mock_icecast2.rb
#   gem 'eventmachine'
# end
