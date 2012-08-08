require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display_uservoice' do
  context 'authenticated user' do
    scenario 'can see uservoice' do
      normal = login_normal
      page.should have_content 'widget.uservoice.com/CqU64j7S3jUTXzgbhFp9oA.js'
    end    
  end
  
  context 'normal user' do
    scenario 'cannot see uservoice' do
      page.should_not have_content 'widget.uservoice.com/CqU64j7S3jUTXzgbhFp9oA.js'
    end      
  end
end



