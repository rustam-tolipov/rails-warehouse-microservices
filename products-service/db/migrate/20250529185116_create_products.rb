class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :sku
      t.string :category
      t.integer :price_cents
      t.boolean :available

      t.timestamps
    end
  end
end
