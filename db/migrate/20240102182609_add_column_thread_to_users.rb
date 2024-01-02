class AddColumnThreadToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :thread, :string, default: ""
  end
end
