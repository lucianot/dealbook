class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country, :null => false
      t.string :region
      t.string :city

      t.timestamps
    end
  end
end
