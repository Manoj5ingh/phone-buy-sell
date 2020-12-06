class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.text :desc
      t.boolean :is_default
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip
      t.bigint :user_id
      t.timestamps
    end
  end
end
