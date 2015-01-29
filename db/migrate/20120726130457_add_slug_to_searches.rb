class AddSlugToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :slug, :string

    add_index :searches, :slug, unique: true
  end
end
