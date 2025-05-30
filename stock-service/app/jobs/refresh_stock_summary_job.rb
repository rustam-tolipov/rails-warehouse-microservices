class RefreshStockSummaryJob < ApplicationJob
  queue_as :default

  def perform
    ActiveRecord::Base.connection.execute("REFRESH MATERIALIZED VIEW stock_summaries")
    Rails.logger.info "[#{Time.now}] StockSummary materialized view refreshed"
  end
end
