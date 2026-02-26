class CreatePlannerItems < ActiveRecord::Migration[8.0]
  def change
    create_table :planner_items do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.time :time_of_day
      t.string :title
      t.text :notes
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
