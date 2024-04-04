class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :mode
      t.string :duration
      t.string :stripe_price_id

      t.timestamps
    end
  end
end
