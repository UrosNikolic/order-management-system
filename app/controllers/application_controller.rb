class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::NotNullViolation, with: :bad_request

  private

  def not_found(error)
    render json: { message: 'not found', error: error.to_s }, status: :not_found
  end

  def bad_request(error)
    render json: { message: 'bad request', error: error.to_s }, status: :bad_request
  end
end
