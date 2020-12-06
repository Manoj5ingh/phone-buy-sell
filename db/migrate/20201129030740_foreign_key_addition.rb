class ForeignKeyAddition < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :addresses, :users
    add_foreign_key :carts,:products
    add_foreign_key :carts,:users
    add_foreign_key :orders,:trackings
    add_foreign_key :orders,:products
    add_foreign_key :trackings, :users
  end
end