class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  after_initialize :set_price, unless: :persisted?

  validates_numericality_of :quantity, :greater_than => 0
  validates_numericality_of :net_price, :greater_than => 0

  private

  def set_price
    self.net_price = product.price * self.quantity
  end
end
