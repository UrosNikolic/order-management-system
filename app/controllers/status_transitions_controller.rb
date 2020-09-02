class StatusTransitionsController < ApplicationController
  before_action :set_order
  before_action :set_status_transition, only: [:update, :destroy]

  def show
    render json: @order.status_transitions
  end

  def create
    begin
      @order.cancelation_reason = status_transition_params[:reason]
      @order.transition(status_transition_params[:status])
      transition = @order.status_transitions.last

      render json: transition, status: :created, location: order_status_transition_url(@order, transition)
    rescue => error
      render json: { message: error.message }, status: :unprocessable_entity
    end
  end

  private
    def set_status_transition
      @status_transition = StatusTransition.find(params[:id])
    end

  def set_order
    @order = Order.find(params[:order_id])
  end

    def status_transition_params
      params.permit(:status, :reason)
    end
end
