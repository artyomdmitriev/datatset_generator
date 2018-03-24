require 'pickup'

class TransactionGenerator
  # the shop expands through time and its sales grow too
  @@year_coefficients = {
    2008 => 1,
    2009 => 1.2,
    2010 => 1.3,
    2011 => 1.5,
    2012 => 1.6,
    2013 => 1.6,
    2014 => 1.62,
    2015 => 1.7,
    2016 => 1.8,
    2017 => 1.9
  }

  @@month_coefficients = {
    1 => 1.1,
    2 => 1.15,
    3 => 1.2,
    4 => 1.25,
    5 => 1.26,
    6 => 1.27,
    7 => 1.3,
    8 => 1.35,
    9 => 1.57,
    10 => 1.6,
    11 => 1.8,
    12 => 1.9
  }


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
      @users.pick(random_amount_of_customers(date)).each do |usr|
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

  def random_amount_of_customers date
    aoc = Random.new.rand(400..600)
    aoc *= @@year_coefficients[date.year]
    unless date.year == 2014 && (date.month == 4 || date.month == 5 || date.month == 6)
      aoc *= @@month_coefficients[date.month]
    end
    aoc.to_i
  end

  def random_amount_of_transactions
    if Random.rand(10) == 0 && Random.rand(10) == 0 && Random.rand(10) == 0 && Random.rand(10) == 0
      Random.new.rand(6..10)
    else
      Random.new.rand(1..2)
    end
  end

  def random_quntity_of_goods
    Random.new.rand(1..3)
  end
end