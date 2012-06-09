class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country, :null => false
      t.string :region, :null => false
      t.string :city, :null => false

      t.timestamps
    end
  end
end
