class AddDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :is_sold, false
    change_column_default :transactions, :is_delivered, false
  end
end
