class AddColumnSubscribeTypeToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :subscribe_type, :string
  end
end
