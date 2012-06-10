class AddVerifiedToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :verified, :boolean
  end
end
