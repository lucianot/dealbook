class SearchesController < ApplicationController
  load_and_authorize_resource
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
    @search = Search.find_by_slug(params[:id])
    query = @search ? @search.keywords : ""
    @results = search_results(query).paginate(:page => params[:page], :per_page => 20)
    respond_with @search
  end

  private
  def search_results(query)
    results = Company.exact(query) + Investor.exact(query)
    results += Company.associated(query) + Investor.associated(query)
    results.uniq
  end
end
