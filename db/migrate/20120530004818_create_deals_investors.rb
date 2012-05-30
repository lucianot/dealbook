class CreateDealsInvestors < ActiveRecord::Migration
  def up
    create_table :deals_investors, :id => false do |t|
      t.references :deal
      t.references :investor
    end
    
    add_index :deals_investors, [ :deal_id, :investor_id ]
    add_index :deals_investors, [ :investor_id, :deal_id ]
  end

  def down
    drop_table :deals_investors
  end
end
