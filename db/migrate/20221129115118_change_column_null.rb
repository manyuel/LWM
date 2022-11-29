class ChangeColumnNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :products, :is_sold, false
    change_column_null :transactions, :is_delivered, false
  end
end
