class RmFksFromPost < ActiveRecord::Migration[7.0]
  def change
    # remove references from posts
    remove_reference :posts, :pickup
    remove_reference :posts, :dropoff
  end
end
