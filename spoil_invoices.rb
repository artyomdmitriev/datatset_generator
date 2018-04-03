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

def spoil_weight weight
  r = Random.rand(3)
  if r == 0
    weight += 'gr'
  elsif r == 1
    weight += 'g'
  else
    if weight.length == 3
      weight.insert(-4, '0,') 
    else
      weight.insert(-4, ',') 
    end
  end
  weight
end

CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/invoices_spoiled.csv", "w", col_sep: '|') do |csv|
  csv << ['invoice_no', 'shipping_courier_short_name', 'shipping_courier_full_name', 'packaging', 'weight']  
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/invoices.csv", headers: true) do |row|
    if spoil?
      csv << [spoil_invoice_no(row[0]), row[4], row[3], row[5], spoil_weight(row[6])]
    else
      csv << [row[0], row[3], row[4], row[5], row[6]]
    end
  end
end