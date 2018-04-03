require 'csv'
require_relative 'product'

@@products = Hash.new

def read_products
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv", headers: true) do |row|
    @@products[row[0]] = Product.new(id: row[0], product_id: row[1], name: row[2], price: row[3], in_sale: row[4], start_date: row[5], end_date: row[6], status: row[7])
  end
end

read_products
CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions_new_fixed_prices.csv", "w") do |csv|
  csv << ['invoice_no', 'quantity', 'tax_amount', 'total_price', 'date', 'user_id', 'product_id', 'country', 'city', 'street_name', 'building', 'apartment', 'postal_code']
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions_new.csv", headers: true) do |row|
    csv << [row[0], row[1], row[2], ((@@products[row[6]].price.to_f * row[1].to_f) + (@@products[row[6]].price.to_f * row[1].to_f * row[2].to_f)).round(2), row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12]]
  end
end