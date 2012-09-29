require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'unlink account from linkedin' do
  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
      })
  end
  
  after { OmniAuth.config.test_mode = false }

  scenario 'valid' do
    visit "/"
    click_link 'Join Now'
    click_link 'Sign Up with Linkedin'
    visit "/users/edit"
    click_link 'Unlink Linkedin account'
    page.should have_content ""
  end
  
  context 'user has password' do
    scenario 'unlink successful'
    scenario 'unlink fail'
  end

  context 'user never created password' do
    scenario 'valid'
    scenario 'invalid'
  end
end