require_relative 'products_loader.rb'

class ProductsGenerator

  attr_accessor :amount_of_products

  def initialize(params={})
    @amount_of_products = params[:amount_of_products]
    @products = load_products_array
  end

  def generate_products
    result = []
    @amount_of_products.times do |i|
      result << @products.sample
    end
    result
  end

end