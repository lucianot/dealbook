class AddSlugToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :slug, :string
  end
end
