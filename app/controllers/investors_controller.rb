class InvestorsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /investors
  # GET /investors.json
  def index
    @investors = Investor.page(params[:page]).order("LOWER(name)")
    respond_with(@investors)
    # @mixpanel.track_event("Investors index")
  end

  # GET /investors/1
  # GET /investors/1.json
  def show
    @investor = Investor.find(params[:id])
    @investor_deals = @investor.deals.order(:close_date)
    respond_with(@investor)
    # @mixpanel.track_event("Investors show", {:investor => "#{@investor.name}"})
  end

  # GET /investors/new
  # GET /investors/new.json
  def new
    @investor = Investor.new
    respond_with(@investor)
  end

  # GET /investors/1/edit
  def edit
    @investor = Investor.find(params[:id])
  end

  # POST /investors
  # POST /investors.json
  def create
    @investor = Investor.new(params[:investor])
    if @investor.save
      flash[:notice] = 'Investor was successfully created.'
    end
    respond_with(@investor, :location => investors_url)
    # @mixpanel.track_event("Investors create", {:investor => "#{@investor.name}"})
  end

  # PUT /investors/1
  # PUT /investors/1.json
  def update
    @investor = Investor.find(params[:id])
    if @investor.update_attributes(params[:investor])
      flash[:notice] = 'Investor was successfully updated.'
    end
    respond_with(@investor)
    # @mixpanel.track_event("Investors update", {:investor => "#{@investor.name}"})
  end

  # DELETE /investors/1
  # DELETE /investors/1.json
  def destroy
    @investor = Investor.find(params[:id])
    @investor.destroy
    flash[:notice] = 'Investor was successfully deleted.'
    respond_with(@investor)
    # @mixpanel.track_event("Investors destroy", {:investor => "#{@investor.name}"})
  end
end

