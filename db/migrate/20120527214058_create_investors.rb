class CreateInvestors < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.string :name, :null => false
      t.text :description
      t.string :website
      t.string :linkedin
      t.string :status
      t.string :category
      t.string :stage

      t.timestamps
    end
    
  end
end
