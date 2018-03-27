
class Transaction
  attr_accessor :invoice_no, :quantity,
                :invoice_date, :user_id, :product_id

  # add product name
  
  def initialize(params={})
    @invoice_no = params[:invoice_no]
    @quantity = params[:quantity]
    @invoice_date = params[:invoice_date]
    @user_id = params[:user_id]
    @product_id = params[:product_id]
  end

  def to_array
  	[@invoice_no, @quantity, @invoice_date, @user_id, @product_id]
  end
end