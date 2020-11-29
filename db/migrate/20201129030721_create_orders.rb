class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :units
      t.integer :status
      t.datetime :delivery_date
      t.text :message
      t.integer :delivery_address_id
      t.timestamps
    end
  end
end
