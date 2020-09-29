class CreateGrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :grounds do |t|
      t.string :title
      t.integer :price
      t.integer :ratingNum, default: 0
      t.integer :ratingSum, default: 0
      t.string :city
      t.string :address
      t.text :description
      t.string :image, default: "default.jpg"
      t.string :category

      t.timestamps
    end
  end
end
