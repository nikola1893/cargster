class AddLengthToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :length, :decimal
  end
end
