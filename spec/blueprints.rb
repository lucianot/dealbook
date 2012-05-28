require 'machinist/active_record'

Company.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Company.catch_phrase }
  website       { 'http://' + Faker::Internet.domain_name }
  linkedin      { 'http://www.linkedin.com/company/' + rand(100_000).to_s } 
  status        { 'acquired' }
end

Company.blueprint(:complete) do
  markets 2
  locations 2
end

Investor.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Company.catch_phrase }
  website       { 'http://' + Faker::Internet.domain_name }
  linkedin      { 'http://www.linkedin.com/company/' + rand(100_000).to_s }
  status        { 'active' }
  category      { 'VC' }
  stage         { [ 'Seed', 'Series A' ] }   # serialize on Investor model
end

Investor.blueprint(:complete) do
  markets 3
  locations 3
end

Market.blueprint do
  name          { Faker::Company.bs }
end

Market.blueprint(:complete) do
  companies 2
  investors 3
end

Location.blueprint do
  country     { 'United States' }
  region      { Faker::Address.us_state_abbr }
  city        { Faker::Address.city }
end

Location.blueprint(:complete) do
  companies 3
  investors 2
end

# Deal.blueprint do
#   date            { (1..500).to_a.rand.days.ago }
#   category        { 'financing round' } 
#   round           { 'series B' } 
#   amount_invested { (1_000_000..10_000_000).to_a.rand } 
#   pre_valuation   { (10_000_000..100_000_000).to_a.rand } 
#   source_url      { 'http://' + Faker::Internet.domain_name }
# end

