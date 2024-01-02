class CreateGptCreations < ActiveRecord::Migration[7.1]
  def change
    create_table :gpt_creations do |t|
      t.text :description
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
