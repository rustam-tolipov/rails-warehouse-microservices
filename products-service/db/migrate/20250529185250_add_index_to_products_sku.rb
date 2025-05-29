class AddIndexToProductsSku < ActiveRecord::Migration[8.0]
  def change
    add_index :products, :sku, unique: true
  end
end
