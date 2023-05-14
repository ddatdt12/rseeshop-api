class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :book

  before_save :set_price

  private

  def set_price
    self.price = book.price
  end
end
