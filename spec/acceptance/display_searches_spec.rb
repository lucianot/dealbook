require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

feature 'search:' do

  context 'guest searches for' do

    scenario 'name of existing company' do
      company = Company.make!(:name => 'Dabee')
      visit '/'
      fill_in 'search_keywords', :with => company.name
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content company.name
    end

    scenario 'investor of existing company' do
      investor = Investor.make!(:name => "Napkn")
      company = Company.make!(:name => "Dabee")
      deal = Deal.make!(:complete, :company => company, :investors => [investor])
      visit '/'
      fill_in 'search_keywords', :with => investor.name
      click_button 'Search'
      page.should have_content "(2 found)"
      page.should have_content company.name
    end

    # scenario 'corporate of existing company' do
    #   corporate = Company.make!(:name => "Abril")
    #   company = Company.make!(:name => "Everwrite")
    #   deal = Deal.make!(:complete, :company => company, :corporates => [corporate])
    #   visit '/'
    #   fill_in 'search_keywords', :with => corporate.name
    #   click_button 'Search'
    #   page.should have_content "(2 found)"
    #   page.should have_content company.name
    # end

    # scenario 'company of existing corporate' do
    #   corporate = Company.make!(:name => "Abril")
    #   company = Company.make!(:name => "Everwrite")
    #   deal = Deal.make!(:complete, :company => company, :corporates => [corporate])
    #   visit '/'
    #   fill_in 'search_keywords', :with => company.name
    #   click_button 'Search'
    #   page.should have_content "(4 found)"
    #   page.should have_content corporate.name
    # end

    scenario 'location of existing company' do
      location = Location.make!(:city => "Salvador", :region => "BA")
      company = Company.make!(:complete, :locations => [location])
      visit '/'
      fill_in 'search_keywords', :with => location.city
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content company.name
    end

    scenario 'market of existing company' do
      market = Market.make!(:name => "finance")
      company = Company.make!(:complete, :markets => [market])
      visit '/'
      fill_in 'search_keywords', :with => market.name
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content company.name
    end

    scenario 'name of existing investor' do
      investor = Investor.make!(:name => 'Napkn')
      visit '/'
      fill_in 'search_keywords', :with => investor.name
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content investor.name
    end

    scenario 'company of existing investor' do
      investor = Investor.make!(:name => "Napkn")
      company = Company.make!(:name => "Dabee")
      deal = Deal.make!(:complete, :company => company, :investors => [investor])
      visit '/'
      fill_in 'search_keywords', :with => company.name
      click_button 'Search'
      page.should have_content "(2 found)"
      page.should have_content investor.name
    end

    scenario 'location of existing investor' do
      location = Location.make!(:city => "Salvador", :region => "BA")
      investor = Investor.make!(:complete, :locations => [location])
      visit '/'
      fill_in 'search_keywords', :with => location.city
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content investor.name
    end

    scenario 'market of existing company' do
      market = Market.make!(:name => "finance")
      investor = Investor.make!(:complete, :markets => [market])
      visit '/'
      fill_in 'search_keywords', :with => market.name
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content investor.name
    end

    scenario 'search for partial company name' do
      company = Company.make!(:name => 'Dabee')
      visit '/'
      fill_in 'search_keywords', :with => company.name[0..2]
      click_button 'Search'
      page.should have_content "(1 found)"
      page.should have_content company.name
    end

    scenario 'search for non-existing query' do
      deal = Deal.make!(:complete)
      visit '/'
      fill_in 'search_keywords', :with => "Impossible_query"
      click_button 'Search'
      page.should have_content "(0 found)"
    end

  end
end