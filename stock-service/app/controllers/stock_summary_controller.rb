class StockSummaryController < ApplicationController
  def index
    results = ActiveRecord::Base.connection.execute(<<-SQL)
        select
            product_id,
            sum(case when direction = 'in' then quantity else 0 end) as total_in,
            sum(case when direction = 'out' then quantity else 0 end) as total_out,
            sum(case when direction = 'in' then quantity else -quantity end) as current_stock
        from transactions
        group by product_id
        order by product_id
        limit 100
    SQL

    render json: results
  end
end
