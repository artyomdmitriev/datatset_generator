require 'faker'
require 'csv'
require 'pickup'
require 'benchmark'
require_relative 'user'
require_relative 'transaction'
require_relative 'transactions_generator'

p 'start: ' + Time.new.to_s
transactions = TransactionGenerator
                                .new(start_date: [2008, 1, 1], end_date: [2017, 12, 31], num_of_users: 2_000_000)
                                .create_transactions

p 'start writing to csv: ' + Time.new.to_s
CSV.open('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions_new.csv', 'w') do |csv|
  csv << ['invoice_no', 'quantity', 'tax_amount', 'total_price', 'date', 'user_id', 'product_id', 'country', 'city', 'street_name', 'building', 'apartment', 'postal_code']
  transactions.each do |v|
    csv << v.to_array
  end
end

p 'end: ' + Time.new.to_s
