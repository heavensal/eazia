class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    drop_table :pay_charges
    drop_table :pay_merchants
    drop_table :pay_payment_methods
    drop_table :pay_subscriptions
    drop_table :pay_webhooks
    drop_table :products
    drop_table :pay_customers
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.string :mode
      t.string :stripe_price_id

      t.timestamps
    end
  end
end
