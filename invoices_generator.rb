require 'csv'
require 'pickup'

# [name]
shipping_couriers = {
  ['DHL', 'DHL Express'] => 10,
  ['FedEx', 'FedEx Corporation'] => 7,
  ['USPS', 'United States Postal Service'] => 4,
  ['UPS', 'United Parcel Service'] => 4
}

packaging = {
  'Pak' => 7,
  'Small Box' => 7,
  'Box' => 2 
}

invoices = Hash.new([])

CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions.csv", headers: true) do |row|
    invoices[row[0]] = [invoices[row[0]][0].to_i + 1, invoices[row[0]][1].to_i + row[1].to_i]
end

puts invoices.size.to_s

CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/invoices.csv", "w") do |csv|
  csv << ['invoice_no', 'quantity_of_products', 'quantity_of_items', 'shipping_courier_short_name', 'shipping_courier_full_name', 'packaging', 'weight']
  invoices.each do |k, v|
    # invoice no, quantity of products, quantity of items
    inv = [k, v].flatten
    # shipping courier
    inv << Pickup.new(shipping_couriers).pick
    inv.flatten!
    # packaging and weight
    if v[1] > 4
      inv << 'Box'
      inv << Random.rand(2000..6000)
    elsif v[1] > 1
      inv << 'Small Box'
      inv << Random.rand(800..2000)
    else
      inv << Pickup.new(packaging).pick
      inv << Random.rand(800..2000)
    end
    csv << inv
  end
end