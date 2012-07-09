class HomeController < ApplicationController
  def index
    @users = User.all

    query = params[:search]
    query = "TOTALLY_INVALID_QUERY" if query.nil? || query.strip.empty?  # TODO: fix hack

    @search = Sunspot.search(Company, Investor) do
      paginate(:page => params[:page])
      fulltext query
    end
  end
end
