class CreateInstagramAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :instagram_accounts do |t|
      t.text :access_token
      t.text :photo_url
      t.string :username
      t.bigint :instagram_business
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
