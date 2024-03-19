class AddColumnAmountToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :amount, :integer
  end
end
