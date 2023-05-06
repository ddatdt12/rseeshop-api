# frozen_string_literal: true

class AddBookAuthorString < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :author, :string
  end
end
