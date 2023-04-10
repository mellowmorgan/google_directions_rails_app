class CreateRides < ActiveRecord::Migration[7.0]
  def change
    create_table :rides do |t|
      t.string :start_address, null: false
      t.string :end_address, null: false
      t.timestamps
    end
  end
end
