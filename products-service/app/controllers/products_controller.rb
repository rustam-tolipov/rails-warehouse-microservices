class ProductsController < ApplicationController
  def index
    products = Product.limit(100)
    render json: products
  end

  def show
    product = Product.find(params[:id])
    render json: product
  end
end
