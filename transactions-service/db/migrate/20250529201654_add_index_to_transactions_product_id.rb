class AddIndexToTransactionsProductId < ActiveRecord::Migration[8.0]
  def change
    add_index :transactions, :product_id
  end
end
