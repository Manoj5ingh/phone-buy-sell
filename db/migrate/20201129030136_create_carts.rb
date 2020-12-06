class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.integer :unit
      t.bigint :product_id
      t.bigint :user_id
      t.timestamps
    end
  end
end
