class DealGraphController < ApplicationController
	def index
		@graph = {}
		@graph[:nodes] = []
		@graph[:edges] = []

		Investor.find_each do |inv|
			@graph[:nodes] << {id: "Investor-#{inv.id}", label: inv.name, type: "Investor", size: inv.deals.count}
		end

		Company.find_each do |inv|
			@graph[:nodes] << {id: "Company-#{inv.id}", label: inv.name, type: "Company", size: 3 }
		end

		Deal.find_each do |deal|
			deal.buyers.each do |buyer|
				@graph[:edges] << {
					id: "#{deal.id}-#{buyer.id}",
					source: "#{buyer.class.name}-#{buyer.id}",
					target: "Company-#{deal.company_id}",
					value: deal.amount.to_i
				}
			end
		end

	end
end
