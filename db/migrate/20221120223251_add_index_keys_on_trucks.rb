class AddIndexKeysOnTrucks < ActiveRecord::Migration[7.0]
  def change
    add_index :trucks, :pickup_id
    add_index :trucks, :dropoff_id
  end
end
