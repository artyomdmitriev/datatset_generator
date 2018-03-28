require 'ffaker'

class DeliveryAddress

  attr_accessor :country, :city, :street_name, :building_number, :apartment, :postal_code

  def initialize(params={})
    @country = params[:country]
    create_delivery_address
  end

  def create_delivery_address
    if @country == 'United Kingdom'
      @city = FFaker::AddressUK.city
      @street_name = FFaker::AddressUK.street_name
      @building_number = FFaker::AddressUK.building_number
      @postal_code = FFaker::AddressUK.zip_code
    elsif @country == 'Germany'
      @city = FFaker::AddressDE.city
      @street_name = FFaker::AddressDE.street_name
      @building_number = FFaker::AddressDE.building_number
      @postal_code = FFaker::AddressDE.zip_code
    elsif @country == 'France'
      @city = FFaker::AddressFR.city
      @street_name = FFaker::AddressFR.street_name
      @building_number = FFaker::AddressFR.building_number
      @postal_code = FFaker::AddressFR.zip_code
    elsif @country == 'Denmark'
      @city = FFaker::AddressDA.city
      @street_name = FFaker::AddressDA.street_name
      @building_number = FFaker::AddressDA.building_number
      @postal_code = FFaker::AddressDA.zip_code
    elsif @country == 'Sweden'
      @city = FFaker::AddressSE.city
      @street_name = FFaker::AddressSE.street_name
      @building_number = FFaker::AddressSE.building_number
      @postal_code = FFaker::AddressSE.zip_code
    elsif @country == 'Canada'
      @city = FFaker::AddressCA.city
      @street_name = FFaker::AddressCA.street_name
      @building_number = FFaker::AddressCA.building_number
      @postal_code = FFaker::AddressCA.zip_code
    elsif @country == 'USA'
      @city = FFaker::AddressUS.city
      @street_name = FFaker::AddressUS.street_name
      @building_number = FFaker::AddressUS.building_number
      @postal_code = FFaker::AddressUS.zip_code
    end
    @apartment = apartment
    self
  end

  def apartment
    x = 4
    r = rand(x)
    if r == 0
      ('A'..'Z').to_a[rand(26)] + ('%.3i' % rand(999))
    elsif r == 1
      ('%.3i' % rand(999))
    elsif r == 2
      ('%.3i' % rand(999)) + ('A'..'Z').to_a[rand(26)]
    elsif r == 3
      ('%.2i' % rand(99))
    end
  end

  def to_array
    [@country, @city, @street_name, @building_number, @apartment, @postal_code]
  end
end