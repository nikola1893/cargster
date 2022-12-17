class AddPickupToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :geo, foreign_key: true
  end
end
