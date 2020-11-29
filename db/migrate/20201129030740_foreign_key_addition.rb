class ForeignKeyAddition < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :user_id, :bigint
    add_column :carts, :user_id, :bigint
    add_column :carts, :product_id, :bigint
    add_column :orders, :user_id, :bigint
    add_column :orders, :product_id, :bigint

    add_foreign_key :addresses, :users
    add_foreign_key :carts,:products
    add_foreign_key :carts,:users
    add_foreign_key :orders,:users
    add_foreign_key :orders,:products
  end
end