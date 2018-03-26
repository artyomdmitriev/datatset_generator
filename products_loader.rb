require 'csv'



CSV.open('D:/Artsemi_Dzmitryieu/products.csv', 'w') do |csv|
  csv_text = File.read('D:\Artsemi_Dzmitryieu\Module4\dataset\online_retail.csv')
  csv_products = CSV.parse(csv_text, headers: true)
  csv_products.each do |row|
    csv << [row.to_a[2][1].to_s.split.map(&:capitalize).join(' ')] unless row.nil?
  end
end