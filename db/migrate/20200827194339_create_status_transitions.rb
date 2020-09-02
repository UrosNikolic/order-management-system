class CreateStatusTransitions < ActiveRecord::Migration[6.0]
  def change
    create_table :status_transitions do |t|
      t.string :event, null: false
      t.string :from, null: false
      t.string :to, null: false
      t.text :reason
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
