class Product 
  attr_accessor :product_id, :name

  def initialize(params={})
    @product_id = params[:product_id]
    @name = params[:product_id]
  end

end