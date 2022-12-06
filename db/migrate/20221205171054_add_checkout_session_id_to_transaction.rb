class AddCheckoutSessionIdToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :checkout_session_id, :string
  end
end
