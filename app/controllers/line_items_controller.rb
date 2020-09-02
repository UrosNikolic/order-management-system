class LineItemsController < ApplicationController
  before_action :set_order
  before_action :set_line_item, only: [:update, :destroy, :show]
  before_action :validate_order_update_status, only: [:update]

  def index
    render json: @order.line_items
  end

  def show
    render json: @line_item
  end

  def create
    @line_item = @order.line_items.build(line_item_params)
    if @line_item.save
      render json: @line_item, status: :created, location: order_line_item_url(@line_item, @line_item.id)
    else
      render json: @line_item.errors, status: :unprocessable_entity
    end
  end

  def update
    if @line_item.update(line_item_params)
      render json: @line_item
    else
      render json: @line_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item.destroy
  end

  private
    def set_line_item
      @line_item = @order.line_items.find(params[:id])
    end

  def set_order
    @order = Order.find(params[:order_id])
  end

  def line_item_params
    params.permit(:quantity, :product_id, :order_id)
  end

  def validate_order_update_status
    render json: { message: 'Unable to edit order if it is not in draft status' }, status: :unprocessable_entity unless @order.draft?
  end
end
