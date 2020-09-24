class CreateGrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :grounds do |t|
      t.string :title
      t.integer :price
      t.integer :rating
      t.string :city
      t.string :address
      t.text :description
      t.string :image, default: "default.jpg"

      t.timestamps
    end
  end
end
