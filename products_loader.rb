require 'csv'
require 'pickup'
require_relative 'product'
require_relative 'products_generator'

 #create price for product
def load_products_array
  products = []
  products_file = File.read('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv')
  products_csv = CSV.parse(products_file, headers: true)
  products_csv.each do |row|
    products << Product.new(product_id: row[0], name: row[1], price: row[2])
  end
  products
end

def load_products_csv
  prod_id = 1
  products_basic = []
  csv_basic = CSV.parse(File.read('D:\Artsemi_Dzmitryieu\Module4\Exit_Task\dataset\online_retail.csv'), headers: true)
  csv_basic.each do |row|
    products_basic << Product.new(id: prod_id, product_id: 'PROD' + ('%.6i' % prod_id), 
                                  name: row.to_a[2][1].to_s.split.map(&:capitalize).join(' ')) unless row.nil?
    prod_id += 1
  end

  products_full = ProductsGenerator.new(products: products_basic, max_prod_id: prod_id).generate_all_products
  CSV.open('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv', 'w') do |csv|
    products_full.each do |product|
      csv << product.to_array_full
    end
  end
end