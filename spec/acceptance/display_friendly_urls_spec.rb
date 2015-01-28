require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'display friendly urls' do

    scenario 'for investors' do
      investor = Investor.make!(:name => 'Napkn Ventures')
      visit '/'
      find('#investors_button').click
      click_link investor.name
      uri = URI.parse(current_url)
      uri.path.should == '/investors/napkn-ventures'
    end

    scenario 'for companies' do
      company = Company.make!(:name => 'Dabee')
      visit '/'
      find('#companies_button').click
      click_link company.name
      uri = URI.parse(current_url)
      uri.path.should == '/companies/dabee'
    end

    scenario 'for companies' do
      investor = Investor.make!(:name => 'e.ventures')
      visit '/'
      fill_in 'search_keywords', :with => investor.name
      click_button 'Search'
      uri = URI.parse(current_url)
      uri.path.should == '/searches/e-ventures'
    end

end
