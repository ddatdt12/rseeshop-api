class CreateBookUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :book_users do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :book_users, [:book_id, :user_id], unique: true
  end
end
