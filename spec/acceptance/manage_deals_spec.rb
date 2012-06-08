require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'manage deals' do
  
  context 'unauthenticated user' do

    scenario 'cannot manage deals' do
      visit '/'
      click_link 'Deals'
      page.should_not have_link 'New deal'
      page.should_not have_link 'Edit'
      page.should_not have_link 'Destroy'    
    end

  end # context

  # context 'regular user' do

  #   scenario 'can create new deal' do
  #     deal = Deal.make
  #     company = Company.make!
  #     investor = Investor.make!
  #     login_normal
  #     click_link 'Deals'
  #     click_link 'New deal'
  #     fill_in 'Close date', :with => deal.deal_date
  #     select company.name, :from => 'Company'      
  #     select investor.name, :from => 'Investors'
  #     select deal.category, :from  => 'Category'
  #     select deal.round, :from => 'Round'
  #     expect do
  #       click_button 'Submit'
  #     end.to change {deal.count}.by(1)
  #     page.should have_content 'Deal was successfully created.'
  #     # page.should have_content deal.summary
  #     # click_link deal.summary
  #     # page.should have_content "Markets: #{market.name}"
  #     # page.should have_content "Locations: #{location.full}"
  #   end

    # scenario 'can edit deals' do
    #   deal = deal.make!
    #   new_name = "#{deal.name} Clone"
    #   login_normal
    #   click_link 'deals'
    #   click_link 'Edit'
    #   fill_in 'Name', :with => new_name
    #   expect do
    #     click_button 'Submit'
    #   end.to change {deal.count}.by(0)
    #   page.should have_content 'deal was successfully updated.'
    #   page.should have_content new_name
    # end

    # scenario 'can delete deals' do
    #   deal = deal.make!
    #   login_normal
    #   click_link 'deals'
    #   expect do      
    #     click_link 'Destroy'
    #   end.to change {deal.count}.by(-1)
    #   page.should have_content 'deal was successfully deleted.'
    #   page.should_not have_content deal.name      
  #   # end

  # end # context

end # feature
