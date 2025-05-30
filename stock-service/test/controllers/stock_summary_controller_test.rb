require "test_helper"

class StockSummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_summary_index_url
    assert_response :success
  end
end
