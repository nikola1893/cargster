class AddLoadingDateToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :loading_date, :date
  end
end
