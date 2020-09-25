class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :ground
      t.references :timetable
      t.references :user
      t.timestamps
    end
  end
end
