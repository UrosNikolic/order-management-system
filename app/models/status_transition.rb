class StatusTransition < ApplicationRecord
  belongs_to :order

  validate :can_create_record?

  def can_create_record?
    if to == 'canceled' && !reason
      errors.add(:product, 'Cannot transition to canceled without reason')
      throw(:abort)
    end
  end
end
