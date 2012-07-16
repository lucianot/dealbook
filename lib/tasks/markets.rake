require 'csv'

namespace :markets do

  desc "export from markets to csv"
  task :export => :environment do

    markets = Market.all
    CSV.open("lib/tasks/markets.csv", "wb") do |csv|
      markets.each do |market|
        csv << ["#{market.name}"]
      end
    end

  end

  desc "import from csv to markets DB"
  task :import => :environment do

    filename = "#{Rails.root}/lib/tasks/markets.csv"
    CSV.foreach(filename) do |name|
      market = Market.new(name: name)
      begin
        market.save!
        puts "Inserted #{name}"
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
        binding.pry
      end
    end
  end

end # namespace