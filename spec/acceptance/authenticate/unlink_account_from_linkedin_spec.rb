require File.expand_path(File.dirname(__FILE__) + '/../acceptance_helper')

feature 'unlink account from linkedin' do
  context 'user has password' do
    scenario 'unlink successful'
    #   login_normal
    #   visit "/users/edit"
    #   click_link 'Disconnect Linkedin account'
    #   page.should have_content "Success! Your Linkedin account is linked."
    #   page.should have_content "Link to your Linkedin account"
    # end

    scenario 'unlink fail'
  end

  context 'user never created password' do
    scenario 'valid'
    scenario 'invalid'
  end
end