class CreateTrackings < ActiveRecord::Migration[6.0]
  def change
    create_table :trackings do |t|
      t.bigint :user_id
      t.string :status
      t.string :message
      t.timestamps
    end
  end
end
