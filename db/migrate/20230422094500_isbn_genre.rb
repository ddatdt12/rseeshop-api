class IsbnGenre < ActiveRecord::Migration[6.1]
  def change
    create_table :isbn_genres do |t|
      t.string :isbn, null: false
      t.references :genre, null: false, foreign_key: true
    end
  end
end
