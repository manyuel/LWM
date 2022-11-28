class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :item
      t.text :description
      t.float :price
      t.boolean :is_sold

      t.timestamps
    end
  end
end
