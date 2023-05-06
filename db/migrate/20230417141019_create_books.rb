# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false, limit: 1000
      t.string :isbn, null: false
      t.integer :price, null: false
      t.integer :year_of_publication, null: false
      t.string :publisher, null: false
      t.string :description, null: false
      t.string :image_s
      t.string :image_m
      t.string :image_l

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
