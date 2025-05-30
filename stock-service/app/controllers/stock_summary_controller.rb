class StockSummaryController < ApplicationController
  def index

    if params[:product_id].present?
      product_id = params[:product_id].to_i
      sql = <<-SQL
        select
            product_id,
            sum(case when direction = 'in' then quantity else 0 end) as total_in,
            sum(case when direction = 'out' then quantity else 0 end) as total_out,
            sum(case when direction = 'in' then quantity else -quantity end) as current_stock
        from transactions
        where product_id = #{product_id}
        group by product_id
        limit 1
      SQL
    else
      sql = <<-SQL
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
    end

    results = ActiveRecord::Base.connection.execute(sql)
    render json: results
  end
end
