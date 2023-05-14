class Api::OrdersController < Api::BaseController
  before_action :authenticate_request!
  before_action :set_order, only: [:show, :pay]

  def index
    orders = @current_user.orders
    render_success orders
  end

  def show
    # render order with items
    order = @current_user.orders.includes(order_items: :book).find(params[:id])

    render_success order, include: { order_items: { include: :book } }
  end

  def create
    order = Orders::CreateOrderService.call(user_id: @current_user.id, book_ids: order_params[:book_ids])

    render_success order, status: :created
  end

  def pay
    Orders::PayOrderService.call(@order.id)

    render_success @order
  end

  private
  def order_params
    params.permit(book_ids: [])
  end

  def set_order
    @order = @current_user.orders.find(params[:id])
  end
end
