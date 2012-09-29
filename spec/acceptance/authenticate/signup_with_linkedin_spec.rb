require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'signup with linkedin' do

  before do 
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new({
      :name => 'nome',
      :email => 'example@sample.com',
      :provider => 'linkedin',
      :uid => '12345'
    })
  end
  
  after { OmniAuth.config.test_mode = false }

  scenario 'valid' do
    visit "/"
    click_link 'Join Now'
    click_link 'Sign Up with Linkedin'
    page.should have_content 'Signed in!'
  end

end



