class CreateMaterializedViewStockSummaries < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW stock_summaries AS
      SELECT
        product_id,
        SUM(CASE WHEN direction = 'in' THEN quantity ELSE 0 END) AS total_in,
        SUM(CASE WHEN direction = 'out' THEN quantity ELSE 0 END) AS total_out,
        SUM(CASE WHEN direction = 'in' THEN quantity ELSE -quantity END) AS current_stock
      FROM transactions
      GROUP BY product_id
    SQL
  end

  def down
    execute "DROP MATERIALIZED VIEW IF EXISTS stock_summaries"
  end
end
