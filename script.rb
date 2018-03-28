require 'faker'
require 'csv'
require 'pickup'
require 'benchmark'
require_relative 'user'
require_relative 'transaction'
require_relative 'transactions_generator'

p 'start: ' + Time.new.to_s
transactions = TransactionGenerator
                                .new(start_date: [2008, 1, 1], end_date: [2009, 12, 31], num_of_users: 20_000)
                                .create_transactions

p 'start writing to csv: ' + Time.new.to_s
CSV.open('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/transactions.csv', 'w') do |csv|
  csv << ['invoice_no', 'quantity', 'date', 'user_id', 'product_id']
  transactions.each do |v|
    csv << v.to_array
  end
end

p 'end: ' + Time.new.to_s
