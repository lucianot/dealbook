class CreateDealings < ActiveRecord::Migration
  def change
    create_table :dealings do |t|
      t.references :deal
      t.references :buyer, :polymorphic => true

      t.timestamps
    end
    add_index :dealings, :deal_id
    add_index :dealings, [:buyer_id, :buyer_type]
    add_index :dealings, [:deal_id, :buyer_id, :buyer_type], :unique => true
    
    # TODO: investigate why dependent delete not working
    add_foreign_key :dealings, :deals, :dependent => :delete
    add_foreign_key :dealings, :investors, :column => 'buyer_id', :dependent => :delete
    add_foreign_key :dealings, :corporates, :column => 'buyer_id', :dependent => :delete
  end
end
