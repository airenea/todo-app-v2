class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :body
      t.integer :user
      t.string :emoji

      t.timestamps
    end
  end
end
