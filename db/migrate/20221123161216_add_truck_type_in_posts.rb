class AddTruckTypeInPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :truck_type, :text, array: true, default: []
  end
end
