require 'csv'
require 'pickup'

 #create price for product
def load_products_array
  products = []
  products_file = File.read('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv')
  products_csv = CSV.parse(products_file, headers: true)
  products_csv.each do |row|
    products << Product.new(product_id: row[0])
  end
  products
end

def load_products_csv
  year_coefficients = {
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
  pckp = Pickup.new(year_coefficients)
  prod_id = 1
  CSV.open('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv', 'w') do |csv|
    csv_text = File.read('D:\Artsemi_Dzmitryieu\Module4\Exit_Task\dataset\online_retail.csv')
    csv_products = CSV.parse(csv_text, headers: true)
    csv << ['prod_id', 'prod_name', 'prod_price']
    csv_products.each do |row|
      csv << ['PROD' + ('%.6i' % prod_id), row.to_a[2][1].to_s.split.map(&:capitalize).join(' '), pckp.pick] unless row.nil?
      prod_id += 1
    end
  end
end