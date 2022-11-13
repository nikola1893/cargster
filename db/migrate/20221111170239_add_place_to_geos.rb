class AddPlaceToGeos < ActiveRecord::Migration[7.0]
  def change
    add_column :geos, :place, :string
  end
end
