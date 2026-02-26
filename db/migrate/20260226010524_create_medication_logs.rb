class CreateMedicationLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :medication_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :medication, null: false, foreign_key: true
      t.date :date
      t.boolean :taken, default: false
      t.time :time_taken
      t.text :notes

      t.timestamps
    end
  end
end
