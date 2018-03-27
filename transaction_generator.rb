require 'pickup'
require_relative 'product.rb'
require_relative 'products_generator.rb'

class TransactionGenerator
  # the shop expands through time and its sales grow too
  @@year_coefficients = {
    2008 => 1,
    2009 => 1.11,
    2010 => 1.15,
    2011 => 1.19,
    2012 => 1.22,
    2013 => 1.24,
    2014 => 1.26,
    2015 => 1.28,
    2016 => 1.2999,
    2017 => 1.3,
    2018 => 1.32,
    2019 => 1.3333
  }

  @@month_coefficients = {
    1 => 1.1,
    2 => 1.15,
    3 => 1.2,
    4 => 1.25,
    5 => 1.26,
    6 => 1.27,
    7 => 1.23,
    8 => 1.20,
    9 => 1.18,
    10 => 1.175,
    11 => 1.16,
    12 => 1.152
  }

  @@invoice_prefixes = ['AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AG', 'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AQ']
  @@prefix_index = 0

  attr_accessor :start_date, :end_date, :invoice_num_start, :num_of_users, :transactions, :users

  def initialize(params={})
    @start_date = Date.new(params[:start_date][0], params[:start_date][1], params[:start_date][2])
    @end_date = Date.new(params[:end_date][0], params[:end_date][1], params[:end_date][2],)
    @invoice_num_start = 1
    @num_of_users = params[:num_of_users]
    @transactions = []
    @users = Pickup.new(create_users)
    @products = ProductsGenerator.new(amount_of_products: 10_000).generate_products
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
          product = @products.sample
          t = Transaction.new(invoice_no: @@invoice_prefixes[@@prefix_index] + ('%.6i' % @invoice_num_start), stock_code:500, description: product.product_id, quantity: random_quntity_of_goods,
                                           invoice_date: date, unit_price: 5.01, customer_id: 5, user: usr)
          @transactions << t
        end
        @invoice_num_start += 1
        @@prefix_index += 1 if @invoice_num_start % 1_000_000 == 0
      end
    end
    @transactions
  end

  def create_users
    users_arr = []
    @num_of_users.times do |i|
      users_arr << User.new
    end
    Hash[users_arr.collect { |item| [item, 1] } ]
  end

  def random_amount_of_customers date
    aoc = Random.new.rand(1200..1400)
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
    if Random.new.rand(5) == 0 && Random.new.rand(5) == 0
      Random.new(1..3)
    else
      1
    end
  end
end