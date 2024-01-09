class RemoveImagesUrlFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :images_url, :string
  end
end
