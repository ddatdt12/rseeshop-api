# frozen_string_literal: true

module Orders
  class CreateOrderService < ApplicationService
    # @param [integer] user_id
    # @param [array] book_ids
    # @return [Order]
    # @raise [ActiveRecord::RecordInvalid]
    def initialize(user_id:, book_ids:)
      super()

      @user_id = user_id
      @book_ids = book_ids
    end

    private

    attr_reader :user_id, :book_ids

    def perform
      # create transaction
      Order.transaction do
        order = Order.create!(user_id:, order_items_attributes: book_ids.map { |book_id| { book_id: } })

        order
      end
    end
  end
end
