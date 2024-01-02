class CreateDalle3Images < ActiveRecord::Migration[7.1]
  def change
    create_table :dalle3_images do |t|
      t.string :link
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
