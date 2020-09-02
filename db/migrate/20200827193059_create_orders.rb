class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :status, null: false
      t.datetime :date, null: false
      t.float :vat, null: false

      t.timestamps
    end
  end
end
