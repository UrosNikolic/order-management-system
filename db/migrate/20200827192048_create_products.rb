class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name, limit: 255, null: false, unique: true
      t.float :price, null: false
      t.timestamps

      t.index  :name, unique: true
    end
  end
end
