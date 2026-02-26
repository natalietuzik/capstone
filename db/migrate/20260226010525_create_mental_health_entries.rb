class CreateMentalHealthEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :mental_health_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.integer :mood
      t.integer :anxiety
      t.decimal :sleep_hours
      t.text :journal

      t.timestamps
    end
    add_index :mental_health_entries, [ :user_id, :date ], unique: true
  end
end
