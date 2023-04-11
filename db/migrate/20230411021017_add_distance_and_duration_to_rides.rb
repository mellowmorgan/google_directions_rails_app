class AddDistanceAndDurationToRides < ActiveRecord::Migration[7.0]
  def change
    add_column :rides, :distance, :decimal, default: nil
    add_column :rides, :duration, :decimal, default: nil
  end
end
