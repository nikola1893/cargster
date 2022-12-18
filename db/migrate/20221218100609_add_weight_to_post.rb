class AddWeightToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :weight, :decimal
  end
end
