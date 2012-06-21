require 'csv'

namespace :import do

  desc "import data from Google Spreadsheet to database"
  task :google => :environment do

    filename = "#{Rails.root}/tmp/import/Brazilian Startup DealBook - Full.csv"
    CSV.foreach(filename) do |deal|

      date, company, deal_category, amount, investors_list, source_url, year = deal

      unless date == "Date"  # check if is header
        # create companies
        Company.find_or_create_by_name!(company) if company

        # create investors
        if investors_list
          investors = investors_list.chomp.split(',').map(&:strip)
          investors.each do |investor|
            unless Company.find_by_name(investor)     # check if exists as Company
              Investor.find_or_create_by_name!(investor)  # if not, assume is Investor and create
            end
          end

        end
      end
    end

  end # google

end # namespace
