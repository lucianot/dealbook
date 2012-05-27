require 'machinist/active_record'

Company.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Lorem.sentence }
  website       { Faker::Internet.domain_name }
  linkedin_url  { 'http://www.linkedin.com/company/' + rand(100_000).to_s } 
  status        { 'acquired' }
  locations     
  markets       
  deals
  investors
end

Investor.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Lorem.sentence }
  website       { Faker::Internet.domain_name }
  linkedin_url  { 'http://www.linkedin.com/company/' + rand(100_000).to_s }
  status        { 'active' }
  category      { 'VC' }
  stages        { ['seed', 'series A', 'late'] }   # serialize on Investor model
  locations
  markets
  deals
  companies
end

Market.blueprint do
  name       { 'mobile' }
  companies
  investors
end

Location.blueprint do
  country     { 'United States' }
  region      { Faker::Address.us_state_abbr }
  city        { Faker::Address.city }
  companies
  investors
end

Deal.blueprint do
  date            { (1..500).to_a.rand.days.ago }
  category        { 'financing round' } 
  round           { 'series B' } 
  amount_invested { (1_000_000..10_000_000).to_a.rand } 
  pre_valuation   { (10_000_000..100_000_000).to_a.rand } 
  source_url      { Faker::Internet.domain_name } 
end

