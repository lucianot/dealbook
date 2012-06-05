class MarketsController < ApplicationController
  load_and_authorize_resource

  # GET /markets
  # GET /markets.json
  def index
    @markets = Market.all  # TODO: sort alpha

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @markets }
    end
  end

  # # GET /markets/1
  # # GET /markets/1.json
  # def show
  #   @market = Market.find(params[:id])

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @market }
  #   end
  # end

  # GET /markets/new
  # GET /markets/new.json
  def new
    @market = Market.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @market }
    end
  end

  # GET /markets/1/edit
  def edit
    @market = Market.find(params[:id])
  end

  # POST /markets
  # POST /markets.json
  def create
    @market = Market.new(params[:market])

    respond_to do |format|
      if @market.save
        format.html { redirect_to markets_path, notice: 'Market was successfully created.' }
        format.json { render json: @market, status: :created, location: @market }
      else
        format.html { render action: "new" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /markets/1
  # PUT /markets/1.json
  def update
    @market = Market.find(params[:id])

    respond_to do |format|
      if @market.update_attributes(params[:market])
        format.html { redirect_to markets_path, notice: 'Market was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @market.errors, status: :unprocessable_entity }
      end
    end
  end  

  # DELETE /markets/1
  # DELETE /markets/1.json
  def destroy
    @market = Market.find(params[:id])
    @market.destroy

    respond_to do |format|
      format.html { redirect_to markets_url, notice: 'Market was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end