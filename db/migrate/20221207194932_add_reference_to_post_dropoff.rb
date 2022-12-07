class AddReferenceToPostDropoff < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :dropoff
  end
end
