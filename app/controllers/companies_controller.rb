class CompaniesController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  # GET /companies
  # GET /companies.json
  def index
    if request.format.to_sym == :html
      @companies = Company.page(params[:page]).order("LOWER(name)")
    else
      @companies = Company.all
    end
    respond_with(@companies)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])
    @company_offers = @company.offers.order(:close_date)
    @company_deals = @company.deals.order(:close_date)
    respond_with(@company)
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new
    respond_with(@company)
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    # binding.pry
    @company = Company.new(params[:company])
    if @company.save
      UpdateMailer.update_email(@company, current_user, action_name).deliver
      flash[:notice] = 'Company was successfully created.'
    end
    respond_with(@company)
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      UpdateMailer.update_email(@company, current_user, action_name).deliver
      flash[:notice] = 'Company was successfully updated.'
    end
    respond_with(@company)
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    UpdateMailer.update_email(@company, current_user, action_name).deliver
    flash[:notice] = 'Company was successfully deleted.'
    respond_with(@company)
  end
end
