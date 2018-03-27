require 'faker'
require 'ffaker'
require 'pickup'

class User
  @@countries = {"United Kingdom": 20, 
                 "Germany": 18, 
                 "France": 15,
                 "Denmark": 5, 
                 "Sweden": 3, 
                 "Canada": 18, 
                 "USA": 25
                }

  @@email_name_delimeters = {".": 10, 
                             "-": 5, 
                             "_": 3
                            }

  @@email_domains = {"@gmail.com": 15, 
                     "@yahoo.com": 10, 
                     "@live.ru": 7, 
                     "@outlook.com": 7, 
                     "@aol.com": 3
                    }

  @@gender = {"m": 30, "f": 60, "n/a": 2}

  @@years_hash = {}

  attr_accessor :country, :city, :first_name, :last_name, :email, :gender,
                :street_name, :building_number, :date_of_birth, :user_id

  def initialize(params={})
    @user_id = params[:user_id]
    @years_pickup = Pickup.new(@@years_hash)
    weight = 1
    (1960..1990).each do |i|
      if i < 1980
        @@years_hash[i] = weight
        weight += 0.3
      else 
        @@years_hash[i] = weight
        weight -= 0.3
      end
    end
    countries_pickup = Pickup.new(@@countries)
    genders_pickup = Pickup.new(@@gender)
    @country = countries_pickup.pick.to_s
    @gender = genders_pickup.pick
    create_country_related_info
    @date_of_birth = create_dob
  end

  def create_country_related_info
    if @country == 'United Kingdom'
      @city = FFaker::AddressUK.city
      @street_name = FFaker::AddressUK.street_name
      @building_number = FFaker::AddressUK.building_number
      @first_name = FFaker::Name.first_name
      @last_name = FFaker::Name.last_name
      @email = get_email
    elsif @country == 'Germany'
      @city = FFaker::AddressDE.city
      @street_name = FFaker::AddressDE.street_name
      @building_number = FFaker::AddressDE.building_number
      @first_name = FFaker::NameDE.first_name
      @last_name = FFaker::NameDE.last_name
      @email = get_email
    elsif @country == 'France'
      @city = FFaker::AddressFR.city
      @street_name = FFaker::AddressFR.street_name
      @building_number = FFaker::AddressFR.building_number
      @first_name = FFaker::NameFR.first_name
      @last_name = FFaker::NameFR.last_name
      @email = get_email
    elsif @country == 'Denmark'
      @city = FFaker::AddressDA.city
      @street_name = FFaker::AddressDA.street_name
      @building_number = FFaker::AddressDA.building_number
      @first_name = FFaker::NameDA.first_name
      @last_name = FFaker::NameDA.last_name
      @email = get_email
    elsif @country == 'Sweden'
      @city = FFaker::AddressSE.city
      @street_name = FFaker::AddressSE.street_name
      @building_number = FFaker::AddressSE.building_number
      @first_name = FFaker::NameSE.first_name
      @last_name = FFaker::NameSE.last_name
      @email = get_email
    elsif @country == 'Canada'
      @city = FFaker::AddressCA.city
      @street_name = FFaker::AddressCA.street_name
      @building_number = FFaker::AddressCA.building_number
      @first_name = FFaker::Name.first_name
      @last_name = FFaker::Name.last_name
      @email = get_email
    elsif @country == 'USA'
      @city = FFaker::AddressUS.city
      @street_name = FFaker::AddressUS.street_name
      @building_number = FFaker::AddressUS.building_number
      @first_name = FFaker::Name.first_name
      @last_name = FFaker::Name.last_name
      @email = get_email
    end
  end

  def create_dob
    dt = rand(Date.civil(1975, 1, 1)..Date.civil(1990, 12, 31))
    if dt.year % 4 == 0 && dt.year % 100 != 0 && dt.month == 2 && dt.day == 29
      Date.new(@years_pickup.pick, dt.month, dt.day - 1)
    else
      Date.new(@years_pickup.pick, dt.month, dt.day)
    end
  end

  def get_email
    email_pickup = Pickup.new(@@email_name_delimeters)
    email = @first_name + ' ' + @last_name
    
    # define divider for email address
    email.gsub! ' ', email_pickup.pick.to_s
    
    # downcase email
    email.downcase! if rand(2) == 1

    email_domains_pickup = Pickup.new(@@email_domains)
    email += email_domains_pickup.pick.to_s
  end

  def to_array
    [@user_id, @first_name, @last_name, @gender, @email, @country, @city, @street_name, @building_number, @date_of_birth]
  end
end