class RmColumnsFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :pickup_place
    remove_column :posts, :dropoff_place
    remove_column :posts, :truck_type
  end
end
