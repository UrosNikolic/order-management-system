class Order < ApplicationRecord
  class UnprocessableError < StandardError; end
  include AASM
  after_initialize :set_defaults, unless: :persisted?

  has_many :line_items
  has_many :status_transitions

  attr_accessor :cancelation_reason

  VAT = 20

  aasm column: :status do
    error_on_all_events :handle_error_for_all_events

    state :draft, initial: true
    state :placed
    state :paid
    state :canceled

    event :placed do
      transitions from: [:draft], to: :placed, guard: Proc.new {|*args| has_line_items?(*args) }, after: Proc.new {|*args| save_transition_event(*args) }
    end

    event :canceled do
      transitions from: [:draft, :placed], to: :canceled, after: Proc.new {|*args| save_transition_event(*args) }
    end

    event :paid do
      transitions from: [:placed], to: :paid, after: Proc.new {|*args| save_transition_event(*args) }
    end
  end

  def transition(new_status)
    self.public_send("#{new_status}!")
  end

  private

  def has_line_items?
    line_items.exists?
  end

  def save_transition_event
    transition_event = status_transitions.build({ from: aasm.from_state, to: aasm.to_state, event: aasm.current_event, reason: cancelation_reason })
    transition_event.save!
  end

  def handle_error_for_all_events(error)
    raise UnprocessableError.new(error.message)
  end

  def set_defaults
    self.vat = VAT
    self.date = DateTime.now
  end
end
