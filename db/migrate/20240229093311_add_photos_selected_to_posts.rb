class AddPhotosSelectedToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :photos_selected, :integer, array: true, default: []
  end
end
