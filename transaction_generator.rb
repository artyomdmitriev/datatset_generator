require 'pickup'

class TransactionGenerator


  attr_accessor :start_date, :end_date, :invoice_num_start, :num_of_users, :transactions, :users

  def initialize(params={})
    @start_date = Date.new(params[:start_date][0], params[:start_date][1], params[:start_date][2])
    @end_date = Date.new(params[:end_date][0], params[:end_date][1], params[:end_date][2],)
    @invoice_num_start = params[:invoice_num_start]
    @num_of_users = params[:num_of_users]
    @transactions = []
    @users = Pickup.new(create_users)
    
  end

  def create_transactions()
    p 'start creating transactions: ' + Time.new.to_s
    years = []
    (@start_date..@end_date).each do |date|
      unless years.include? date.year
        years << date.year
        p date.year
      end
      @users.pick(random_amount_of_customers).each do |usr|
        random_amount_of_transactions.times do
          t = Transaction.new(invoice_no: @invoice_num_start, stock_code:500, description: 'desc', quantity: random_quntity_of_goods,
                                           invoice_date: date, unit_price: 5.01, customer_id: 5, user: usr)
          @transactions << t
        end
        @invoice_num_start += 1
      end
    end
    @transactions
  end

  def create_users()
    users_arr = []
    @num_of_users.times do |i|
      users_arr << User.new
    end
    Hash[users_arr.collect { |item| [item, 1] } ]
  end

  def random_amount_of_customers
    Random.new.rand(400..600)
  end

  def random_amount_of_transactions
    Random.new.rand(1..5)
  end

  def random_quntity_of_goods
    Random.new.rand(1..3)
  end
end