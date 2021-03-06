class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :validate_order_update_status, only: [:update]

  def index
    @orders = Order.all

    render json: @orders
  end

  def show
    render json: @order
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.permit(:vat, :date)
  end

  def validate_order_update_status
    render json: { message: 'Unable to edit order if it is not in draft status' }, status: :unprocessable_entity unless @order.draft?
  end
end
