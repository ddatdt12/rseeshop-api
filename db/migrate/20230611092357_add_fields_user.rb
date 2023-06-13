class AddFieldsUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :favorite_genre, :string
    add_column :users, :legacy_id, :integer
    add_index :users, :legacy_id, unique: true
  end
end
