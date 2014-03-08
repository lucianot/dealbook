require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display uservoice' do
  pending

  context 'user' do
    scenario 'can see uservoice' do
      login_normal
      page.should have_css '#uservoice'
    end
  end

  context 'guest' do
    scenario 'cannot see uservoice' do
      visit '/'
      page.should_not have_css '#uservoice'
    end
  end
end



