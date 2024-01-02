class AddColumnInstagramToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :instagram, :string, default: "@"
  end
end
