class CreateMedications < ActiveRecord::Migration[8.0]
  def change
    create_table :medications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :dosage
      t.text :instructions

      t.timestamps
    end
  end
end
