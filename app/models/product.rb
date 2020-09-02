class Product < ApplicationRecord
  has_many :line_items
  has_many :orders, through: :line_items

  before_destroy :can_destroy?, prepend: true

  validates :name, :price, presence: true


  private

  def can_destroy?
    if orders.exists?
      errors.add(:product, 'Cannot delete product with orders')
      throw(:abort)
    end
  end
end
