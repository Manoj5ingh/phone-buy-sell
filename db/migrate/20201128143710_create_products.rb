class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :manufacturer
      t.string :storage_size
      t.string :model
      t.integer :year_of_manufactur
      t.string :colour
      t.decimal :actual_price
      t.integer :units
      t.decimal :selling_price
      t.decimal :buying_price
      t.string :condition

      t.timestamps
    end
  end
end
