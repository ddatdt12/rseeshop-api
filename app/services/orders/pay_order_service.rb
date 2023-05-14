# frozen_string_literal: true

module Orders
  class PayOrderService < ApplicationService

    # @param [integer] order_id
    # @return nil
    # @raise [ActiveRecord::RecordInvalid]
    def initialize(order_id)
      super()

      @order_id = order_id
    end

    private

    attr_reader :order_id

    def perform
      Order.transaction do
        order = Order.find(order_id)
        order.pay!

        order.order_items.each do |order_item|
          BookUser.create!(book_id: order_item.book_id, user_id: order.user_id)
        end
      end
    end
  end
end
