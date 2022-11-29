class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :country, :string
    add_column :users, :area, :string
    add_column :users, :batch, :integer
    add_column :users, :rating, :float
  end
end
