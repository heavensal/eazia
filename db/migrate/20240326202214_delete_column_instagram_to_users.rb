class DeleteColumnInstagramToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :instagram
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :token
    remove_column :users, :ig_page
  end
end
