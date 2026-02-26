class CreateJournalEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :journal_entries do |t|
      t.integer :user_id, null: false
      t.date :date
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :journal_entries, :user_id
    add_foreign_key :journal_entries, :users
  end
end
