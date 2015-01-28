class DealingsController < ApplicationController
  load_and_authorize_resource :except => [:index]
  respond_to :json

  # GET /dealings.json
  def index
    @deals = Dealing.all
    respond_with(@deals)
  end
end
