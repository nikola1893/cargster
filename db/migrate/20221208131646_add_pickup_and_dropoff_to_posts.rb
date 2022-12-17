class AddPickupAndDropoffToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :pickup_place, :string
    add_column :posts, :dropoff_place, :string
  end
end
