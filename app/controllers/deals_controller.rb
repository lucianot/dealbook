class DealsController < ApplicationController
  load_and_authorize_resource except: [:create, :update]
  respond_to :html, :json

  # GET /deals
  # GET /deals.json
  def index
    if request.format.to_sym == :html
      @deals = Deal.page(params[:page]).order("close_date DESC")
    else
      @deals = Deal.all
    end
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
    @deal = Deal.new company_id: params[:company_id]
    respond_with(@deal)
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
  end

  # POST /deals
  # POST /deals.json
  def create
    # TODO: wrap in transaction
    buyers = params[:deal][:offerings][:buyers]
    params[:deal].delete(:offerings)
    @deal = Deal.new(params[:deal])
    authorize! :create, @deal # CanCan gem

    update_offerings_for(@deal, buyers)

    if @deal.save
      UpdateMailer.update_email(@deal, current_user, action_name).deliver
      flash[:notice] = 'Deal was successfully created.'
    end
    respond_with(@deal)
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    # TODO: wrap in transaction
    buyers = params[:deal][:offerings][:buyers]
    params[:deal].delete(:offerings)
    @deal = Deal.find(params[:id])
    authorize! :update, @deal # CanCan gem

    update_offerings_for(@deal, buyers)

    # @deal.verified = false
    if @deal.update_attributes(params[:deal])
      UpdateMailer.update_email(@deal, current_user, action_name).deliver
      flash[:notice] = 'Deal was successfully updated.'
    end
    respond_with(@deal)
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    UpdateMailer.update_email(@deal, current_user, action_name).deliver
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
def update_offerings_for(deal, buyers)
  current_offerings = deal.offerings(true)

  # check if all current buyers are still selected
  current_offerings.each do |current_offering|
    current_buyer_string = "#{current_offering.buyer_type}:#{current_offering.buyer_id}"
    if buyers.include?(current_buyer_string)
      # if current buyer is still selected, simply remove it from control list
      buyers.delete(current_buyer_string)
    else
      # if current buyer is no longer selected, destroy offering
      current_offering.destroy
    end
  end

  # create offerings for new buyers
  buyers.each do |buyer|
    unless buyer.blank?
      buyer_type, buyer_id = buyer.split(":")
      new_offering = deal.offerings.find_or_create_by_buyer_id_and_buyer_type(
        buyer_type: buyer_type,
        buyer_id: buyer_id.to_i)
    end
  end
end
