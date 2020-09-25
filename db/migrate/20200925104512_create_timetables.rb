class CreateTimetables < ActiveRecord::Migration[6.0]
  def change
    create_table :timetables do |t|
      t.string :day
      t.integer :from
      t.integer :to
      t.timestamps
    end
  end
end
