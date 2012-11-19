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

  scenario 'valid linkedin credentials' do
    user = User.make!
    login(user)
    link_to_linkedin
    visit "/users/edit"
    page.should have_content "Unlink from your Linkedin account"
  end

  scenario 'invalid linkedin credentials' do
    OmniAuth.config.mock_auth[:linkedin][:info][:email] = ''
    user = User.make!
    login(user)
    link_to_linkedin
    visit "/users/edit"
    page.should have_content "Link to your Linkedin account"
  end
end


