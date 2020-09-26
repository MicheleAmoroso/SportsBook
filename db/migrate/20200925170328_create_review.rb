class CreateReview < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer 'rating'
      t.text 'comments'
      t.references 'user'
      t.references 'ground'
      
    end
  end
end
