class SearchesController < ApplicationController
  respond_to :html, :json

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.create!(params[:search])
    respond_with @search
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @search = Search.find(params[:id])
    @results = search_results(@search.keywords)
    respond_with @search
  end

  private
  def search_results(query)
    results = Company.exact(query) + Investor.exact(query)
    results += Company.associated(query) + Investor.associated(query)
  end
end
