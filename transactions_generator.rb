require 'pickup'
require_relative 'product.rb'
require_relative 'products_generator.rb'
require_relative 'users_loader.rb'
require_relative 'delivery_address.rb'

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

  @@tax_coefficient_per_country = {
    "United Kingdom" => 0.2,
    "Germany" => 0.18,
    "France" => 0.19,
    "Denmark" => 0.11,
    "Sweden" => 0.12,
    "Canada" => 0.094,
    "USA" => 0.05
  }

  @@invoice_prefixes = ['AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AG', 'AK', 'AL', 'AM', 'AN', 'AO', 'AP', 'AQ']
  @@prefix_index = 0

  @@delivery_addr = {n: 70, y:30}
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
        delivery_address = [nil, nil, nil, nil, nil, nil]
        if delivery_address_exists?
          delivery_address = DeliveryAddress.new(country: usr[1].to_s).to_array
        end
        random_amount_of_transactions.times do
          product = @products.sample
          tax_amount = @@tax_coefficient_per_country[usr[1]]
          quantity_of_goods = random_quantity_of_goods
          total_price = ((quantity_of_goods * product.price.to_f) + (tax_amount.to_f * (quantity_of_goods * product.price.to_f))).round(2)
          t = Transaction.new(invoice_no: @@invoice_prefixes[@@prefix_index] + ('%.6i' % @invoice_num_start), quantity: quantity_of_goods,
                                          tax_amount: tax_amount.to_f, total_price: total_price,
                                          invoice_date: date, user_id: usr[0].to_s, product_id: product.product_id, delivery_address: delivery_address)
          @transactions << t
        end
        @invoice_num_start += 1
        @@prefix_index += 1 if @invoice_num_start % 1_000_000 == 0
      end
    end
    @transactions
  end

  def create_users
    users_arr = load_users_array
    Hash[users_arr.collect { |item| [item, 1] } ]
  end

  def random_amount_of_customers date
    aoc = Random.new.rand(1200..1400)
    aoc *= @@year_coefficients[date.year]
    unless (date.year == 2014 && (date.month == 4 || date.month == 5 || date.month == 6)) || (date.year == 2015 && (date.month == 2 || date.month == 3 || date.month == 4))
      aoc *= @@month_coefficients[date.month]
    end
    aoc.to_i
  end

  def random_amount_of_transactions
  	a = Random.rand(10)
  	b = Random.rand(10)
  	c = Random.rand(10)
    if a == 0 && b == 0
      Random.new.rand(3..6)
    elsif a == 0 && b == 0 && c == 0
      Random.new.rand(6..15)
  	else
      Random.new.rand(1..2)
    end
  end

  def random_quantity_of_goods
    if Random.new.rand(5) == 0 && Random.new.rand(5) == 0
      Random.new.rand(1..3)
    else
      1
    end
  end

  def delivery_address_exists?
    if Pickup.new(@@delivery_addr).pick == :n
      false
    else
      true
    end
  end
end