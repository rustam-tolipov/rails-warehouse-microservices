require "faraday"
require "faraday/retry"

class StockServiceClient
  BASE_URL = ENV.fetch("STOCK_SERVICE_URL", "http://localhost:3002")

  def self.trigger_refresh
    conn = Faraday.new(url: BASE_URL) do |f|
      f.request :retry, max: 3, interval: 0.5, backoff_factor: 2
      f.options.timeout = 5
      f.adapter Faraday.default_adapter
    end

    response = conn.post("/refresh_stock_summary")

    unless response.success?
      Rails.logger.warn "[StockServiceClient] Stock-service failed to refresh (#{response.status})"
    end
  rescue Faraday::ConnectionFailed => e
    Rails.logger.error "[StockServiceClient] Connection failed: #{e.message}"
  rescue Faraday::TimeoutError => e
    Rails.logger.error "[StockServiceClient] Timeout: #{e.message}"
  rescue => e
    Rails.logger.error "[StockServiceClient] Unknown error: #{e.message}"
  end
end
