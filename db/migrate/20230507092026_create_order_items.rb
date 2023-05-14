class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.decimal :price, null: false, precision: 10, scale: 2

      t.timestamps
    end

    add_index :order_items, [:order_id, :book_id], unique: true
  end
end
