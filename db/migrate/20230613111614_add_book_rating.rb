class AddBookRating < ActiveRecord::Migration[6.1]
  def change
    create_table :book_ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.integer :rating, null: false, default: 0

      t.timestamps
    end

    add_index :book_ratings, %i[book_id user_id], unique: true
  end
end
