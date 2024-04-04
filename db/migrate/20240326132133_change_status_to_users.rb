class ChangeStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :status, :string, default: 'freemium'
  end
end

# db/migrate/20240326132133_change_status_to_users.rb
