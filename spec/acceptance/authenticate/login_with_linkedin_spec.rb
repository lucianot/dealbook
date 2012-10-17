require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'login with linkedin' do
  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :provider => 'linkedin',
      :uid => '12345',
      :info => { :name => 'user', :email => "user@example.com" }
    })
  end
  after { OmniAuth.config.test_mode = false }
  
  context 'created account with linkedin' do
    scenario 'valid' do
      sign_up_linkedin
      click_link 'Logout'
      login_linkedin
    end
  end

  context 'previously linked account to linkedin' do
    scenario 'valid' do
      user = User.make!
      login(user)
      link_linkedin
      click_link 'Logout'
      login_linkedin
    end
  end

  # TODO: get user permission & ask for account password or new email
  context 'previously signed up with email only, same as linkedin' do
    scenario 'valid'
    scenario 'invalid'
  end
end