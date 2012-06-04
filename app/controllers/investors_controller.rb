class InvestorsController < ApplicationController
  load_and_authorize_resource

  # GET /investors
  # GET /investors.json
  def index
    @investors = Investor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @investors }
    end
  end

  # GET /investors/1
  # GET /investors/1.json
  def show
    @investor = Investor.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @investor }
    end
  end

  # GET /investors/new
  # GET /investors/new.json
  def new
    @investor = Investor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @investor }
    end
  end

  # GET /investors/1/edit
  def edit
    @investor = Investor.find(params[:id])
  end

  # POST /investors
  # POST /investors.json
  def create
    @investor = Investor.new(params[:investor])

    respond_to do |format|
      if @investor.save
        format.html { redirect_to investors_path, notice: 'Investor was successfully created.' }
        format.json { render json: @investor, status: :created, location: @investor }
      else
        format.html { render action: "new" }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /investors/1
  # PUT /investors/1.json
  def update
    @investor = Investor.find(params[:id])

    respond_to do |format|
      if @investor.update_attributes(params[:investor])
        format.html { redirect_to @investor, notice: 'Investor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @investor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /investors/1
  # DELETE /investors/1.json
  def destroy
    @investor = Investor.find(params[:id])
    @investor.destroy

    respond_to do |format|
      format.html { redirect_to investors_url, notice: 'Investor was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end