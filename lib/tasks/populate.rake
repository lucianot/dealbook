require 'csv'

namespace :import do

  desc "import data from Google Spreadsheet to database"
  task :google => :environment do

    # clean record
    # Company.delete_all
    # Investor.delete_all
    # Deal.delete_all

    # parse csv
    filename = "#{Rails.root}/tmp/import/Brazilian Startup DealBook - Full.csv"
    CSV.foreach(filename) do |deal|

      date_str, company_name, category_str, amount_str, buyers_names, source_url, year = deal

      unless date_str == "Date"  # check if is header
        # create companies
        if company_name
          company = Company.find_by_name(company_name)
          company ||= Company.create!(name:company_name)
        end

        # create investors
        buyers = []
        if buyers_names
          buyers_array = buyers_names.chomp.split(',').map(&:strip)
          buyers_array.each do |buyer_name|
            corporate = Company.find_by_name(buyer_name)    # check if exists as Company
            if corporate
              buyers << ["Company", corporate.id]
            else
              investor = Investor.find_by_name(buyer_name)
              investor ||= Investor.create(name:buyer_name)
              buyers << ["Investor", investor.id]
            end
          end
        end

        # parse deal attributes
        date = convert_date(date_str)
        category = convert_category(category_str)
        currency, amount = convert_amount(amount_str)

        # create deals
        deal = Deal.new(close_date: date,
                        category: category,
                        company_id: company.id,
                        currency: currency,
                        amount: amount,
                        source_url: source_url,
                        verified: true)
        buyers.each do |buyer|
          deal.offerings.find_or_create_by_buyer_id_and_buyer_type(
            :buyer_type => buyer[0],
            :buyer_id => buyer[1])
        end
        begin
          deal.save!
        rescue
          binding.pry
        end

      end # unless
    
    end # csv

  end # google

  private 
  def convert_date(date_str)
    year, month, day = date_str.split('/')
    date = Date.new(year.to_i, month.to_i)
  end

  def convert_category(category_str)
    category = category_str
    category = case category_str
    when 'Raised from'  then 'raised funds from'
    when 'Incubated by' then 'incubated by'
    when 'Acquired by'  then 'was acquired by'
    when 'Merged with'  then 'merged with'
    when 'Shuts down', 'Shuts down Brazilian operation' then 'shut down'
    end
    category
  end

  def convert_amount(amount_str)
    if amount_str.nil? || amount_str == 'undisclosed'
      currency, amount = nil
    else
      currency, short_amount = amount_str.split
      currency = 'USD' unless currency == 'BRL'
      amount_num, amount_letter = short_amount[0..-2], short_amount[-1,1]
      multiplier = case amount_letter
      when 'k', 'K' then 1_000
      when 'm', 'M' then 1_000_000
      when 'b', 'B' then 1_000_000_000
      end
      amount = amount_num.to_i * multiplier
    end  
    return currency, amount  
  end


end # namespace

