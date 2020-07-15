# A class should have only a single responsibility. - Wikipedia
# A class should have only one reason to change. - Robert C. Martin aka Uncle Bob

require 'net/http'
require 'json'

class ZipCodeService
  def initialize(environment = 'development')
    @env = environment
  end

  def zip_codes
    url = 'http://sepomex.icalialabs.com/api/v1/zip_codes'
    url = 'https://myreal.server.com' if env == 'production'

    puts "[ZipCodeCollection] GET #{url}"
    response = Net::HTTP.get_response(URI(url))

    return [] if response.code != '200'

    zip_codes = JSON.parse(response.body)['zip_codes']
    zip_codes.map do |params|
      ZipCode.new(
        id: params['id'],
        code: params['d_codigo'],
        city: params['d_ciudad'],
        state: params['d_estado']
      )
    end
  end

  private

  attr_reader :env
end

class ZipCode
  attr_reader :id, :code, :city, :state

  def initialize(id:, code:, city:, state:)
    @id = id
    @code = code 
    @city = city
    @state = state
  end

  def to_s
    "#{id} #{city}"
  end
end

zip_code_service = ZipCodeService.new
puts zip_code_service.zip_codes
