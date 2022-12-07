class AddTruckTypeToPost < ActiveRecord::Migration[7.0]
  def change
    # add column as an array
    add_column :posts, :truck_type, :text, array: true, default: []
  end
end
