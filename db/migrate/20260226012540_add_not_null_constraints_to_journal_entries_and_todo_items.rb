class AddNotNullConstraintsToJournalEntriesAndTodoItems < ActiveRecord::Migration[8.0]
  def change
    change_column_null :journal_entries, :date,  false
    change_column_null :journal_entries, :title, false
    change_column_null :todo_items,      :title, false
  end
end
