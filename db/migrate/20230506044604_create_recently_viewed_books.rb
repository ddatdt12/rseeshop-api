# frozen_string_literal: true

class CreateRecentlyViewedBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :recently_viewed_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
