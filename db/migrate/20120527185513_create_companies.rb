class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :null => false
      t.text :description
      t.string :website
      t.string :linkedin
      t.string :status

      t.timestamps
    end

  end
end
