class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :company, :string
    add_column :users, :coc, :string
    add_column :users, :vat, :string
  end
end
