class RenameLatToLatitudeAndLongToLongitude < ActiveRecord::Migration[7.0]
  def change
    # rename_column :table, :old_column, :new_column
    rename_column :geos, :lat, :latitude
    rename_column :geos, :long, :longitude
  end
end
