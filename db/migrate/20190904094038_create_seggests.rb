class CreateSeggests < ActiveRecord::Migration[5.2]
  def change
    create_table :seggests do |t|
      t.string :product_name, null: false
      t.string :description
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
