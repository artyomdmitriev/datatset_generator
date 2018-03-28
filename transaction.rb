
class Transaction
  attr_accessor :invoice_no, :quantity,
                :invoice_date, :user_id, :product_id, :delivery_address

  # add product name
  
  def initialize(params={})
    @invoice_no = params[:invoice_no]
    @quantity = params[:quantity]
    @tax_amount = params[:tax_amount]
    @total_price = params[:total_price]
    @invoice_date = params[:invoice_date]
    @user_id = params[:user_id]
    @product_id = params[:product_id]
    @delivery_address = params[:delivery_address]
  end

  def to_array
  	[@invoice_no, @quantity, @tax_amount, @total_price, @invoice_date, @user_id, @product_id, @delivery_address].flatten!
  end
end