require 'machinist/active_record'

Company.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Company.catch_phrase }
  website       { 'http://' + Faker::Internet.domain_name }
  linkedin      { 'http://www.linkedin.com/company/' + rand(100_000).to_s }
  status        { 'acquired' }
end

Company.blueprint(:complete) do
  markets     2
  locations   2
end

Investor.blueprint do
  name          { Faker::Company.name }
  description   { Faker::Company.catch_phrase }
  website       { 'http://' + Faker::Internet.domain_name }
  linkedin      { 'http://www.linkedin.com/profile/view?id=' + rand(100_000).to_s }
  status        { 'active' }
  category      { 'VC' }
  stage         { [ 'Seed', 'Series A' ] }
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
  region      { Faker::Address.state_abbr }
  city        { Faker::Address.city }
end

Location.blueprint(:complete) do
  companies 3
  investors 2
end

Deal.blueprint do
  close_date     { (1..500).to_a.sample.days.ago.to_date }
  category       { 'raised funds from' }
  round          { 'Series B' }
  currency       { 'USD' }
  amount         { (10_000_000..10_001_000).to_a.sample }
  pre_valuation  { (100_000_000..100_001_000).to_a.sample }
  source_url     { 'http://' + Faker::Internet.domain_name }
end

Deal.blueprint(:simple) do
  company        { Company.make! }
  investors      { [Investor.make!] }
end

Deal.blueprint(:complete) do
  company        { Company.make! }
  investors 2
  corporates     { [ Company.make! ] }
end

Dealing.blueprint do
end

Dealing.blueprint(:investor) do
  deal
  investor
end

User.blueprint do
  email                   { "user#{sn}@example.com" }
  password                { 'password' }
  password_confirmation   { password }
  full_name               { 'Faker::Name.name' }
  role                    { 'normal' }
end

User.blueprint(:admin) do
  role                    { 'admin' }
end

User.blueprint(:mod) do
  role                    { 'moderator' }
end

User.blueprint(:linkedin) do
  provider                { 'linkedin' }
  uid                     { '12345' }
  password                { '' }
  password_confirmation   { password }  
end











