# frozen_string_literal: true

class IsbnGenre < ActiveRecord::Migration[6.1]
  def change
    create_table :isbn_genres do |t|
      t.string :isbn, null: false
      t.string :genre, null: false
    end

    # composite primary key
    add_index :isbn_genres, %(isbn genre), unique: true
  end
end
