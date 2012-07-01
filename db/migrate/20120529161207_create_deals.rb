class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.date :close_date, :null => false
      t.string :category
      t.string :round
      t.string :currency
      t.integer :amount
      t.integer :pre_valuation
      t.text :source_url
      t.references :company

      t.timestamps
    end
    add_index :deals, :company_id
    # add_foreign_key :deals, :companies, :dependent => :delete

  end
end
