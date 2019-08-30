class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.integer :status, default: 0
      t.string :address, null: false
      t.string :phone, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
