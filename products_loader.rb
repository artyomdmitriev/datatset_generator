require 'csv'

 #create price for product
def load_products_array
  products = []
  prodcuts_file = File.read('D:/Artsemi_Dzmitryieu/products.csv')
  products_csv = CSV.parse(prodcuts_file, headers: true)
  products_csv.each do |row|
    products << Product.new(product_id: row[0], name: row[1])
  end
  products
end

def load_products_csv
  prod_id = 1
  CSV.open('D:/Artsemi_Dzmitryieu/products.csv', 'w') do |csv|
    csv_text = File.read('D:\Artsemi_Dzmitryieu\Module4\dataset\online_retail.csv')
    csv_products = CSV.parse(csv_text, headers: true)
    csv << ['prod_id', 'prod_name']
    csv_products.each do |row|
      csv << [prod_id, row.to_a[2][1].to_s.split.map(&:capitalize).join(' ')] unless row.nil?
      prod_id += 1
    end
  end
end