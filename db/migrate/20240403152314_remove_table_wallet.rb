class RemoveTableWallet < ActiveRecord::Migration[7.1]
  def change
    drop_table :wallets
  end
end
