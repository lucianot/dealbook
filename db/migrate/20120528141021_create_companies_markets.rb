class CreateCompaniesMarkets < ActiveRecord::Migration
  def up
    create_table :companies_markets, :id => false do |t|
      t.references :company
      t.references :market
    end
    
    add_index :companies_markets, [ :company_id, :market_id ]
    add_index :companies_markets, [ :market_id, :company_id ]
  end

  def down
    drop_table :companies_markets
  end
end
