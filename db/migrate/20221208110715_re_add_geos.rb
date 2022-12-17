class ReAddGeos < ActiveRecord::Migration[7.0]
  def change
    # add foregin key
    add_reference :posts, :pickup, index: true

  end
end
