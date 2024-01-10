class AddPicturesGeneratedToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :pictures_generated, :integer, default: 1
  end
end
