class RatingCountBook < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :rating_count, :integer, default: 0
    add_column :books, :rating_avg, :float, default: 0.0
  end
end
