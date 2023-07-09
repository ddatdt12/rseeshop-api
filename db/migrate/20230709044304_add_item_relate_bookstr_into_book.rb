class AddItemRelateBookstrIntoBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :item_related_book_str, :string
  end
end
