class StockSummaryController < ApplicationController
  def index
    if params[:product_id]
      summary = StockSummary.find_by(product_id: params[:product_id])
      render json: summary
    else
      summaries = StockSummary.limit(100)
      render json: summaries
    end
  end

  def refresh
    RefreshStockSummaryJob.perform_later
    render json: { status: "Refresh job enqueued" }
  end
end
