class AddIndexToPosts < ActiveRecord::Migration[7.0]
  def change
    add_index :posts, :pickup_id
    add_index :posts, :dropoff_id
  end
end
