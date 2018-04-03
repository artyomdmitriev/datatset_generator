require 'csv'

def spoil?
  if Random.rand(2) == 0 && Random.rand(2) == 0
    true
  else
    false
  end
end

def spoil_invoice_no invoice_no
  new_inv_no = invoice_no.split('')
  if Random.rand(2) == 0
    new_inv_no.map! {|x| x == '0' ? '#' : x}
  else
    new_inv_no.insert(0, '!') if Random.rand(2) == 0
    new_inv_no.insert(0, ',') if Random.rand(2) == 0
    new_inv_no.insert(0, '.') if Random.rand(2) == 0
  end
  new_inv_no.join('')
end

def spoil_product_price price
  price.sub('.', ',')
end

def spoil_date date
  if Random.rand(2) == 0
    date.gsub('-', '/')
  else
    date.gsub('-', '.')
  end
end

CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions_spoiled.csv", "w", col_sep: '|') do |csv|
  csv << ['invoice_no', 'quantity', 'tax_amount', 'total_price', 'date', 'user_id', 'product_id', 'country', 'city', 'street_name', 'building', 'apartment', 'postal_code']  
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions.csv", headers: true) do |row|
    if spoil?
      csv << [spoil_invoice_no(row[0]), row[1], spoil_product_price(row[2]), spoil_product_price(row[3]), spoil_date(row[4]), row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12]]
    else
      csv << [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11], row[12]]
    end
  end
end