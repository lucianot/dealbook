class CreateCompaniesLocations < ActiveRecord::Migration
  def up
    create_table :companies_locations, :id => false do |t|
      t.references :company
      t.references :location
    end
    
    add_index :companies_locations, [ :company_id, :location_id ]
    add_index :companies_locations, [ :location_id, :company_id ]
  end

  def down
    drop_table :companies_locations
  end
end
