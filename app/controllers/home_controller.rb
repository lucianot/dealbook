class HomeController < ApplicationController
  def index
    @users = User.all
    @deals = Deal.order('updated_at DESC').limit(10)
    @deal_count = Deal.count
    @investor_count = Investor.count
    @company_count = Company.count
  end
end
