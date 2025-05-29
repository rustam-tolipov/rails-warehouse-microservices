class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.integer :product_id
      t.integer :quantity
      t.string :direction
      t.string :source

      t.timestamps
    end
  end
end
