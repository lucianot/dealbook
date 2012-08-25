require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display uservoice' do

  context 'user' do
    scenario 'can see uservoice' do
      login_normal
      page.should have_content 'widget.uservoice.com/CqU64j7S3jUTXzgbhFp9oA.js'
    end    
  end
  
  context 'guest' do
    scenario 'cannot see uservoice' do
      page.should_not have_content 'widget.uservoice.com/CqU64j7S3jUTXzgbhFp9oA.js'
    end      
  end
end



