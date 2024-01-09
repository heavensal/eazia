class AddColumnPromptToDalle3Images < ActiveRecord::Migration[7.1]
  def change
    add_column :dalle3_images, :prompt, :text
  end
end
