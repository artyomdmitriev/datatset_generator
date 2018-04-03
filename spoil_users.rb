require 'csv'

def spoil?
  if Random.rand(2) == 0 && Random.rand(2) == 0
    true
  else
    false
  end
end

def spoil_user_no user_no
  new_usr_no = user_no.split('')
  if Random.rand(2) == 0
    new_usr_no.map! {|x| x == '0' ? '#' : x}
  else
    new_usr_no.insert(0, '!') if Random.rand(2) == 0
    new_usr_no.insert(0, ',') if Random.rand(2) == 0
    new_usr_no.insert(0, '.') if Random.rand(2) == 0
  end
  new_usr_no.join('')
end

def spoil_date date
  if Random.rand(2) == 0
    date.gsub('-', '/')
  else
    date.gsub('-', '.')
  end
end

def spoil_email email
  email.gsub('@', '[at]')
end

def spoil_name name
  name.upcase
end

def spoil_date date
  if Random.rand(2) == 0
    date.gsub('-', '/')
  else
    date.gsub('-', '.')
  end
end

CSV.open("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/users_spoiled.csv", "w", col_sep: '|') do |csv|
  csv << ['user_no', 'first_name', 'last_name', 'gender', 'email', 'date_of_birth', 'country', 'city', 'street_name', 'building_number', 'apartment', 'postal_code']  
  CSV.foreach("D:/Artsemi_Dzmitryieu/Module4/Exit_Task/dataset/users.csv", headers: true) do |row|
    if spoil?
      csv << [spoil_user_no(row[0]), spoil_name(row[1]), spoil_name(row[2]), row[3], spoil_email(row[4]), spoil_date(row[5]), spoil_name(row[6]), row[7], row[8], row[9], row[10], row[11]]
    else
      csv << [row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7], row[8], row[9], row[10], row[11]]
    end
  end
end