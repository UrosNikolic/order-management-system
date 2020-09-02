#module StateMachine
#  extend ActiveSupport::Concern
#  include AASM
#
#  aasm column: :status do
#    state :draft, initial: true
#    state :placed
#    state :paid
#    state :canceled
#
#    event :placed do
#      transitions from: [:draft], to: :placed, after: Proc.new {|*args| save_transition_event(*args) }
#    end
#
#    event :canceled do
#      transitions from: [:draft, :placed], to: :canceled
#    end
#
#    event :paid do
#      transitions from: [:placed], to: :paid
#    end
#  end
#
#  private
#
#  def save_transition_event
#    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
#  end
#end
