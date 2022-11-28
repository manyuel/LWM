class AddMoreColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :city, :string
    add_column :users, :batch, :integer
  end
end
