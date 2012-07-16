class HomeController < ApplicationController
  def index
    @users = User.all
    @deals = Deal.order('updated_at DESC').limit(10)
    @deal_count = Deal.count
    @investor_count = Investor.count
    @company_count = Company.count

    if user_signed_in?
      @mixpanel.track_event("Home Page", {:user => "registered"})
    else
      @mixpanel.track_event("Home Page", {:user => "guest"})
    end
  end
end
