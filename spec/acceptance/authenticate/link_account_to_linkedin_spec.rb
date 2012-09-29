require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'link account to linkedin' do

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
    login_normal
    visit "/users/edit"
    click_link 'Associate a Linkedin account'
    click_link 'Sign Up with Linkedin'
    page.should have_content 'Signed in!'
  end


end


