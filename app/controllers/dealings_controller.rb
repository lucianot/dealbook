class DealsController < ApplicationController
  load_and_authorize_resource

  before_filter :set_expense_expensable, :only => :create

  def create
  end

  private

  def set_expense_expensable
    if expensable = params[:expensable]
      id, model = expensable.split('-')
      @expense.expensable = current_user.send(model.downcase.pluralize).find(id)
    end
  end

end