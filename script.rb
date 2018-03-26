require 'faker'
require 'csv'
require 'pickup'
require 'benchmark'
require_relative 'user'
require_relative 'transaction'
require_relative 'transaction_generator'

p 'start: ' + Time.new.to_s
transactions = TransactionGenerator
                                .new(start_date: [2008, 1, 1], end_date: [2009, 1, 1], invoice_num_start: 1, num_of_users: 50_000)
                                .create_transactions

p 'start writing to csv: ' + Time.new.to_s
CSV.open('D:/Artsemi_Dzmitryieu/data_small.csv', 'w') do |csv|
  csv << ['invoice_no', 'stock_code', 'description', 'quantity', 'date', 'price', 'first_name', 'last_name', 'email', 'country', 'street_name', 'building_number']
  transactions.each do |v|
    csv << v.to_array
  end
end

p 'end: ' + Time.new.to_s
