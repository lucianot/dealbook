class ChangeAmountToBigint < ActiveRecord::Migration
  def change
    change_column :deals, :amount, :bigint
  end
end
