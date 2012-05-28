class CreateInvestorsLocations < ActiveRecord::Migration
  def up
    create_table :investors_locations, :id => false do |t|
      t.references :investor
      t.references :location
    end
    
    add_index :investors_locations, [ :investor_id, :location_id ]
    add_index :investors_locations, [ :location_id, :investor_id ]
  end

  def down
    drop_table :investors_locations
  end
end
