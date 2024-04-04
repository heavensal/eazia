class AddColumnWalletToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :wallet, :integer, default: 10
  end
end
