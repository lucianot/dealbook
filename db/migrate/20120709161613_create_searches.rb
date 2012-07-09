class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords

      t.timestamps
    end
  end
end
