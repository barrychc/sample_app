source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1' #9.3.2, make sample users with semi-realistic names and email addresses 
gem 'pg', '0.12.2'
gem 'will_paginate', '3.0.3' #9.3.3, one of the simplest and most robust pagination methods
gem 'bootstrap-will_paginate', '0.0.6' #9.3.3, configures will_paginate to use Bootstrap’s pagination styles
group :development, :test do
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
end

group :development do
  gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
  gem 'capybara', '1.1.2'
  gem 'rb-fchange', '0.0.5'
  gem 'rb-notifu', '0.0.4'
  gem 'win32console', '1.3.0'
  require 'rbconfig'
  gem 'wdm', '0.1.0' if RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i  
  gem 'guard-spork', '1.2.0'
  gem 'childprocess', '0.3.9'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'  
end

