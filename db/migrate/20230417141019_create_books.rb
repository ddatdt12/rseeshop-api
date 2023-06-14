# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :isbn, null: false
      t.integer :price, null: false
      t.integer :year_of_publication, null: false
      t.string :publisher, null: false
      t.string :image_s
      t.string :image_m
      t.string :image_l
      t.text :tag_str, null: false
      t.string :author, null: false

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
