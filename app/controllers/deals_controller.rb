class DealsController < ApplicationController
  load_and_authorize_resource :except => [:create, :update]
  respond_to :html, :json

  # GET /deals
  # GET /deals.json
  def index
    @deals = Deal.all
    respond_with(@deals)
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id])
    respond_with(@deal)
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new
    respond_with(@deal)
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
    @buyers_for_selected = @deal.buyers.map { |b| "#{b.class.name}:#{b.id}" }
  end

  # POST /deals
  # POST /deals.json
  def create
    # TODO: wrap in transaction
    buyers = params[:deal][:offerings][:buyers]
    params[:deal].delete(:offerings)
    @deal = Deal.new(params[:deal])
    authorize! :read, @deal # CanCan
    
    create_offerings_for(buyers)

    if @deal.save
      flash[:notice] = 'Deal was successfully created.'
    end
    respond_with(@deal, :location => deals_url)
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    # TODO: wrap in transaction
    buyers = params[:deal][:offerings][:buyers]
    params[:deal].delete(:offerings)

    # TODO: correct approach to destroy all then rebuild selected?
    @deal = Deal.find(params[:id])
    authorize! :read, @deal

    @deal.offerings.delete_all  # TODO: correct to destroy here?
    create_offerings_for(buyers)

    @deal.verified = false
    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was successfully updated.'
    end
    respond_with(@deal, :location => deals_url)
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    flash[:notice] = 'Deal was successfully deleted.'
    respond_with(@deal)
  end

  # TODO: check if RESTful. Can refactor into update?
  def verify
    @deal = Deal.find(params[:id])
    @deal.verified = true

    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was marked as verified.'
    end
    respond_with(@deal)
  end

  def unverify
    @deal = Deal.find(params[:id])
    @deal.verified = false

    if @deal.update_attributes(params[:deal])
      flash[:notice] = 'Deal was marked as unverified.'
    end
    respond_with(@deal)
  end
end

private
def create_offerings_for(buyers)
    buyers.each do |buyer|
    unless buyer.blank?
      buyer_type, buyer_id = buyer.split(":")
      offering = Dealing.new
      offering.buyer_type = buyer_type
      offering.buyer_id = buyer_id.to_i
      @deal.offerings << offering
    end
  end
end



