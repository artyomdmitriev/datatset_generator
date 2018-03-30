class Product 
  attr_accessor :id, :product_id, :name, :price, :in_sale, :start_date, :end_date, :status

  def initialize(params={})
    @id = params[:id]
    @product_id = params[:product_id]
    @name = params[:name]
    @price = params[:price]
    @in_sale = params[:in_sale]
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @status = params[:status]
  end

  def to_array
    [@id]
  end

  def to_array_full
    [@id, @product_id, @name, @price, @in_sale, @start_date, @end_date, @status]
  end
end