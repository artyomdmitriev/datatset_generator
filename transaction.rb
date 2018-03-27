
class Transaction
  attr_accessor :invoice_no, :stock_code, :description, :quantity,
                :invoice_date, :unit_price, :customer_id, :user

  # add product name
  
  def initialize(params={})
    @invoice_no = params[:invoice_no]
    @stock_code = params[:stock_code]
    @description = params[:description]
    @quantity = params[:quantity]
    @invoice_date = params[:invoice_date]
    @unit_price = params[:unit_price]
    @customer_id = params[:customer_id]
    @user = params[:user]
  end

  def inspect
  	"#{@invoice_no} #{@stock_code} #{@description} #{@quantity} #{@invoice_date} #{@unit_price} #{@customer_id} #{@user}"
  end

  def to_array
  	ary = [@invoice_no, @stock_code, @description, @quantity, @invoice_date, @unit_price] << @user.to_array
  	ary.flatten!
  end
end