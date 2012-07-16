source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'json', '~> 1.7'
gem 'thin'

# db
gem 'pg'
gem 'foreigner', '~> 1.1'

# users and roles
gem 'devise', '~> 2.1'
gem 'cancan', '~> 1.6'

# versions
gem 'paper_trail', '~> 2.6'

# views
gem 'simple_form', '~> 2.0'
gem 'country_select', '~> 1.0'
gem 'will_paginate', '~> 3.0'
gem 'bootstrap-sass', '~> 2.0.4.0'

# search
gem 'pg_search'

# analytics
gem 'mixpanel'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '>= 1.0.3'

  gem 'chosen-rails', '~> 0.9'
  gem 'jquery_datepicker', '~> 0.3'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.10'
  gem 'capybara', '~> 1.1'
  gem 'machinist', '~> 2.0'
  gem 'faker', '~> 1.0'
  gem 'shoulda-matchers', '~> 1.1'
  gem 'valid_attribute', '~> 1.1'
  gem 'rb-fsevent', '~> 0.9' #, :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec', '~> 0.7'
  gem 'spin', '~> 0.4'
  gem 'guard-spin', '~> 0.1'
  gem 'pry'

  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :production do
  gem 'heroku'
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
