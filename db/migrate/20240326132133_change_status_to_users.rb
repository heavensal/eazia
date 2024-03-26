class ChangeStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :status, :string, default: 'freemium'
  end
end
