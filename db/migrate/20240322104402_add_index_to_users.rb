class AddIndexToUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
