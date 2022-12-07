class AddReferenceToPost < ActiveRecord::Migration[7.0]
  def change
    # add index column in posts table
    add_reference :posts, :pickup
  end
end
