class HomeController < ApplicationController
  def index
    @users = User.all
    @deals = Deal.order('updated_at DESC').limit(10)
  end
end
