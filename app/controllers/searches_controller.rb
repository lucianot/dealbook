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
    respond_with @search
  end
end
