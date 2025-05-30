require "faraday"

class StockServiceClient
  BASE_URL = ENV.fetch("STOCK_SERVICE_URL", "http://localhost:3002")

  def self.trigger_refresh
    response = Faraday.post("#{BASE_URL}/refresh_stock_summary")
    unless response.success?
      Rails.logger.warn "[StockServiceClient] Failed to refresh: #{response.status}"
    end
  rescue => e
    Rails.logger.error "[StockServiceClient] Error: #{e.message}"
  end
end
