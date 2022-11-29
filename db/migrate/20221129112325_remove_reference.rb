class RemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :users, :product, index: true, foreign_key: true
    add_reference :products, :user, null: false, foreign_key: true
  end
end
