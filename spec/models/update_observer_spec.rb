require 'spec_helper'
# require_relative '../support/fund_share_daily_price_creator'

# describe UpdateObserver do

#   before :all do
#     ActiveRecord::Base.observers = [:update_observer]
#     ActiveRecord::Base.instantiate_observers
#   end

#   before :each do
#     @company = Company.make
#   end

#   it 'sends mail when company is inserted' do
#     Company.observers.enable(:update_observer) do
#       expect { Company.make }
#         .to change{ fund_share.most_recent_daily_price_at_cache }
#     end
#   end

#   it 'sends mail when company is updated' do
#   end

#   it 'sends mail when company is deleted' do
#   end
# end
