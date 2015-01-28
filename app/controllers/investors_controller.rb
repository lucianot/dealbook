class InvestorsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /investors
  # GET /investors.json
  def index
    if request.format.to_sym == :html
      @investors = Investor.page(params[:page]).order("LOWER(name)")
    else
      @investors = Investor.all
    end
    respond_with(@investors)
  end

  # GET /investors/1
  # GET /investors/1.json
  def show
    @investor = Investor.find(params[:id])
    @investor_deals = @investor.deals.order(:close_date)
    respond_with(@investor)
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
      UpdateMailer.update_email(@investor, current_user, action_name).deliver
      flash[:notice] = 'Investor was successfully created.'
    end
    respond_with(@investor, :location => investors_url)
  end

  # PUT /investors/1
  # PUT /investors/1.json
  def update
    @investor = Investor.find(params[:id])
    if @investor.update_attributes(params[:investor])
      UpdateMailer.update_email(@investor, current_user, action_name).deliver
      flash[:notice] = 'Investor was successfully updated.'
    end
    respond_with(@investor)
  end

  # DELETE /investors/1
  # DELETE /investors/1.json
  def destroy
    @investor = Investor.find(params[:id])
    @investor.destroy
    UpdateMailer.update_email(@investor, current_user, action_name).deliver
    flash[:notice] = 'Investor was successfully deleted.'
    respond_with(@investor)
  end
end
