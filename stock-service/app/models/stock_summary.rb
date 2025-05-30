class StockSummary < ApplicationRecord
  self.primary_key = :product_id
  self.table_name = "stock_summaries"

  def readonly?
    true
  end
end
