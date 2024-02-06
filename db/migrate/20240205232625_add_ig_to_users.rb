class AddIgToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :ig_page, :bigint
  end
end
