require 'faraday'

class ProductClient
  BASE_URL = ENV.fetch("PRODUCTS_SERVICE_URL", "http://localhost:3001")

  def self.fetch_product(product_id)
    response = Faraday.get("#{BASE_URL}/products/#{product_id}")
    if response.success?
      JSON.parse(response.body)
    else
      { id: product_id, name: "Unknown", sku: "N/A" }
    end
  rescue StandardError => e
    Rails.logger.error "ProductClient failed: #{e.message}"
    { id: product_id, name: "Error", sku: "Error" }
  end
end
