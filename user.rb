require 'faker'
require 'ffaker'
require 'pickup'

class User
  @@countries = {"United Kingdom": 20, 
                 "Germany": 18, 
                 "France": 15,
                 "Netherlands": 5, 
                 "Norway": 3, 
                 "Spain": 10, 
                 "Switzerland": 11
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

  attr_accessor :country, :first_name, :last_name, :email,
                :street_name, :building

  def initialize()
    countries_pickup = Pickup.new(@@countries)
    @country = countries_pickup.pick.to_s
    @first_name = FFaker::Name.name
    @last_name = FFaker::Name.name
    @email = get_email
    @street_name = FFaker::Address.street_name
    @building = FFaker::Address.building_number
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
    [@first_name, @last_name, @email, @country, @street_name, @building]
  end
end