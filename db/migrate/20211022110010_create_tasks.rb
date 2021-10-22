class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :body
      t.boolean :completion
      t.integer :user
      t.integer :category_id
      t.date :date

      t.timestamps
    end
  end
end
