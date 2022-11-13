class CreateGeos < ActiveRecord::Migration[7.0]
  def change
    create_table :geos do |t|
      t.references :post, null: false, foreign_key: true
      t.string :type
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
