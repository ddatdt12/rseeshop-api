class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items, source: :book

  enum status: { pending: 0, completed: 1 }
  before_save :set_total_price, if: :new_record?

  scope :with_items, -> { includes(:order_items, :items) }

  accepts_nested_attributes_for :order_items

  def pay!
    update!(status: :completed)
  end

  private

  def set_total_price
    self.total_price = order_items.sum { |order_item| order_item.book.price}
  end
end
