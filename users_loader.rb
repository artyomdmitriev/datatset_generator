require 'csv'
require_relative 'user.rb'

# we don't need all info about users in fact table so only id is used
def load_users_array
  users = []
  users_file = File.read('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/users.csv')
  users_csv = CSV.parse(users_file, headers: true)
  users_csv.each do |row| 
    users << [row[0], row[6]]
  end
  users
end

def load_users_csv
  CSV.open('D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/users.csv', 'w') do |csv|
    csv << ['user_id', 'first_name', 'last_name', 'gender', 'email', 'date_of_birth', 
      'country', 'city', 'street_name', 'building_number', 'apartment', 'postal_code']
    2_000_000.times do |i|
      id = 'USR' + ('%.8i' % (i + 1))
      csv << User.new(user_id: id).to_array
    end
  end
end