class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :prompt
      t.text :description
      t.string :images_url, array: true, default: []
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
      t.string :status, default: 'draft'
      t.datetime :scheduled_at
      t.datetime :published_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
