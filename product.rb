class Product 
  attr_accessor :product_id, :name, :price

  def initialize(params={})
    @product_id = params[:product_id]
    @name = params[:name]
    @price = params[:price]
  end

  def to_array
    [@product_id]
  end
end