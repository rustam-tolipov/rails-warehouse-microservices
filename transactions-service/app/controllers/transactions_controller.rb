class TransactionsController < ApplicationController
  def create
    transaction = Transaction.new(transaction_params)
    if transaction.save
      render json: transaction, status: :created
    else
      render json: { errors: transaction.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if params[:product_id]
      transactions = Transaction.where(product_id: params[:product_id]).order(created_at: :desc)
    else
      transactions = Transaction.all.order(created_at: :desc)
    end
    render json: transactions
  end

  private

  def transaction_params
    params.require(:transaction).permit(:product_id, :quantity, :direction, :source)
  end
end
