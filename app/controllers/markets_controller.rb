class MarketsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /markets
  # GET /markets.json
  def index
    @markets = Market.page(params[:page]).order("LOWER(name)")
    respond_with(@markets)
  end

  # # GET /markets/1
  # # GET /markets/1.json
  # def show
  #   @market = Market.find(params[:id])
  #   respond_with(@market)
  # end

  # GET /markets/new
  # GET /markets/new.json
  def new
    @market = Market.new
    respond_with(@market)
  end

  # GET /markets/1/edit
  def edit
    @market = Market.find(params[:id])
  end

  # POST /markets
  # POST /markets.json
  def create
    @market = Market.new(params[:market])
    if @market.save
      flash[:notice] = 'Market was successfully created.'
    end
    respond_with(@market, :location => markets_url)
  end

  # PUT /markets/1
  # PUT /markets/1.json
  def update
    @market = Market.find(params[:id])
    if @market.update_attributes(params[:market])
      flash[:notice] = 'Market was successfully updated.'
    end
    respond_with(@market, :location => markets_url)
  end

  # DELETE /markets/1
  # DELETE /markets/1.json
  def destroy
    @market = Market.find(params[:id])
    @market.destroy
    flash[:notice] = 'Market was successfully deleted.'
    respond_with(@market)
  end
end
