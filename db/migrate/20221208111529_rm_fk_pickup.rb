class RmFkPickup < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :pickup, index: true
  end
end
