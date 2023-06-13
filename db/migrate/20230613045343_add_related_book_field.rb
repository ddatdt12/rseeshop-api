class AddRelatedBookField < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :related_book_str, :text
  end
end
