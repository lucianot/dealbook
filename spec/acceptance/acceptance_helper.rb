require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'capybara/rspec'

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# RSpec.configure do |config|
# end

def sign_up_new_user
  user = User.make
  visit "/"
  click_link 'Sign up'
  fill_in 'Full name', with: user.full_name
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  fill_in 'Password confirmation', with: user.password
  click_button 'Sign up'
end

def login(user)
  visit "/"
  click_link 'Login'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => user.password
  click_button 'Sign in'
end

def login_normal
  normal = User.make!
  login(normal)
  normal
end

def login_admin
  admin = User.make!(:admin)
  login(admin)
  admin
end

def login_mod
  mod = User.make!(:mod)
  login(mod)
  mod
end


