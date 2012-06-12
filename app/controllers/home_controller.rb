class HomeController < ApplicationController
  def index
    @users = User.all

    @search = Sunspot.search(Company, Investor) do
      fulltext params[:search]
    end
  end
end
