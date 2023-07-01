class AddIndexAvgRatingToBook < ActiveRecord::Migration[6.1]
  def change
    add_index :books, :rating_avg
  end
end
