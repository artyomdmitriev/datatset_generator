require_relative 'products_loader.rb'

class ProductsGenerator

  @@start_dates = {
    Date.new(2005, 04, 13) => 20,
    Date.new(2006, 05, 25) => 17,
    Date.new(2007, 07, 12) => 13,
    Date.new(2008, 04, 3) => 8
  }

  @@end_dates = {
    Date.new(2009, 03, 2) => 20,
    Date.new(2010, 8, 17) => 17,
    Date.new(2011, 6, 14) => 27,
    Date.new(2012, 2, 28) => 21,
    Date.new(9999, 12, 31) => 50
  }

  @@price_coefficients = {
    5.99 => 20,
    7.59 => 19,
    8.99 => 17,
    10.99 => 15,
    13.59 => 13,
    15.99 => 10,
    17.59 => 8,
    25.99 => 4,
    51.95 => 1
  }

  attr_accessor :amount_of_products

  def initialize(params={})
    @amount_of_products = params[:amount_of_products]
    @products = params[:products]
    @price_coefficients_pckp = Pickup.new(@@price_coefficients)
    @start_date_pckp = Pickup.new(@@start_dates)
    @end_date_pckp = Pickup.new(@@end_dates)
    @max_prod_id = params[:max_prod_id] + 1 unless params[:max_prod_id].nil?
  end

  def generate_products
    @products = load_products_array
    result = []
    @amount_of_products.times do |i|
      result << @products.sample
    end
    result
  end

  def generate_all_products
    updated_products = []
    @products.each do |prod|
      st_date = @start_date_pckp.pick
      end_date = @end_date_pckp.pick
      while end_date < st_date
        end_date = @end_date_pckp.pick
      end
      status = 'y'
      in_sale = 'y'
      if end_date.year != 9999
        status = 'n'
        in_sale = 'n' if Random.rand(2) == 1
      end

      updated_products << Product.new(
                            id: prod.id,
                            product_id: 'PROD' + ('%.6i' % prod.id), 
                            name: prod.name,
                            price: @price_coefficients_pckp.pick,
                            in_sale: in_sale,
                            start_date: st_date,
                            end_date: end_date,
                            status: status
                            )
    end
    duplicate_products_with_end_dates(updated_products)
  end

  def duplicate_products_with_end_dates products
    extended_products = []
    full_end_dates = {
      Date.new(2013, 1, 15) => 20,
      Date.new(2014, 5, 13) => 17,
      Date.new(2015, 4, 23) => 27,
      Date.new(2016, 3, 2) => 21
    }

    products.each do |p|
      if(p.status == 'y' && Random.rand(3) == 1)
        puts 'product to be changed: ' + p.to_array_full.to_s

        new_end_date_pickup = Pickup.new(full_end_dates)
        new_end_date = new_end_date_pickup.pick

        old_product = Product.new(id: p.id, product_id: p.product_id, name: p.name, price: p.price,
                                  in_sale: 'n', start_date: p.start_date, end_date: new_end_date, status: 'n')
        extended_products << old_product
        puts 'changed old product: ' + old_product.to_array_full.to_s

        new_product = Product.new(id: @max_prod_id, product_id: p.product_id, name: p.name, price: p.price,
                                  in_sale: 'y', start_date: new_end_date, end_date: Date.new(9999, 12, 31), status: 'y')
        extended_products << new_product
        puts 'new product: ' + new_product.to_array_full.to_s

        @max_prod_id += 1 
      else
        extended_products << p
      end
    end

    extended_products
  end
end