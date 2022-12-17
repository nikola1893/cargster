class RmFkGeo < ActiveRecord::Migration[7.0]
  def change
    remove_reference :posts, :geo, foreign_key: true
  end
end
