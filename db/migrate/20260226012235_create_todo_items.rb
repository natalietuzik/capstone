class CreateTodoItems < ActiveRecord::Migration[8.0]
  def change
    create_table :todo_items do |t|
      t.integer :user_id, null: false
      t.string :title
      t.text :notes
      t.boolean :completed, default: false, null: false
      t.integer :priority, default: 2, null: false

      t.timestamps
    end
    add_index :todo_items, :user_id
    add_foreign_key :todo_items, :users
  end
end
