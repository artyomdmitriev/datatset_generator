require 'csv'

def spoil?
  if Random.rand(2) == 0 && Random.rand(2) == 0
    true
  else
    false
  end
end

def spoil_product_no product_no
  new_prod_no = product_no.split('')
  if Random.rand(2) == 0
    new_prod_no.map! {|x| x == '0' ? '#' : x}
  else
    new_prod_no.insert(0, '!') if Random.rand(2) == 0
    new_prod_no.insert(0, ',') if Random.rand(2) == 0
    new_prod_no.insert(0, '.') if Random.rand(2) == 0
  end
  new_prod_no.join('')
end

def spoil_product_name name
  name.upcase
end

def spoil_product_price price
  price.sub(',', '.')
end

CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products_spoiled.csv", "w", col_sep: '|') do |csv| 
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/products.csv") do |row|
    if spoil?
      csv << [row[0], spoil_product_no(row[1]), spoil_product_name(row[2]), spoil_product_price(row[3]), row[4], row[6], row[5], row[7] ]
    else
      csv << [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]]
    end
  end
end