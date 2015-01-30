class CreateInvestorsMarkets < ActiveRecord::Migration
  def up
    create_table :investors_markets, id: false do |t|
      t.references :investor
      t.references :market
    end
    
    add_index :investors_markets, [ :investor_id, :market_id ]
    add_index :investors_markets, [ :market_id, :investor_id ]
  end

  def down
    drop_table :investors_markets
  end
end
