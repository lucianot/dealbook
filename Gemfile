source 'https://rubygems.org'
ruby '2.1.5'

gem 'rails'
gem 'jquery-rails'
gem 'json'
gem 'puma'
gem 'rake'

# db
gem 'pg'
gem 'foreigner', '~> 1.2'

# users and roles
gem 'devise', '~> 2.1'
gem 'cancan', '~> 1.6'
gem 'omniauth-linkedin', '~> 0.0'

# versions
gem 'paper_trail', '~> 2.6'

# views
gem 'simple_form', '~> 2.0'
gem 'country_select', '~> 1.0'
gem 'will_paginate', '~> 3.0'
gem 'bootstrap-sass', '~> 2.2.1'

# search
gem 'pg_search'
gem 'friendly_id', '~> 4.0'

# analytics
# gem 'mixpanel', '~> 3.1'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'chosen-rails', '~> 0.9'
  gem 'jquery_datepicker', '~> 0.4'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.12'
  gem 'capybara', '~> 2.0'
  gem 'machinist', '~> 2.0'
  gem 'faker', '~> 1.1'
  gem 'shoulda-matchers', '~> 1.4'
  gem 'valid_attribute', '~> 1.3'
  gem 'rb-fsevent', '~> 0.9' #, :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec', '~> 2.3'
  gem 'spin', '~> 0.5'
  gem 'guard-spin', '~> 0.3'
  gem 'pry'
  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'thin'
  gem 'quiet_assets'
end

group :test do
  gem 'email_spec'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
