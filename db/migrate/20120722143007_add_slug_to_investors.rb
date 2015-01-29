class AddSlugToInvestors < ActiveRecord::Migration
  def change
    add_column :investors, :slug, :string

    add_index :investors, :slug, unique: true
  end
end
