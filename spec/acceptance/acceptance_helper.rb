require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")
require 'capybara/rspec'

# Put your acceptance spec helpers inside /spec/acceptance/support
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# RSpec.configure do |config|
# end

def sign_up_new_user
  user = User.make
  visit "/"
  click_link 'Join Now'
  click_link 'Sign up with Email'
  fill_in 'Full name', with: user.full_name
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  fill_in 'Password confirmation', with: user.password
  click_button 'Sign up'
  user
end

def login(user)
  visit "/"
  click_link 'Sign in'
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

def logout
  click_link 'Sign out'
end

def sign_up_with_linkedin
  visit "/"
  click_link 'Join Now'
  click_link 'Sign up with Linkedin'
end

def login_with_linkedin
  visit "/"
  click_link 'Sign in'
  click_link 'Sign in with Linkedin'
end

def link_to_linkedin
  visit "/users/edit"
  click_link 'Link to your Linkedin account'
end

def unlink_from_linkedin
  visit "/users/edit"
  click_link 'Unlink from your Linkedin account'
end
