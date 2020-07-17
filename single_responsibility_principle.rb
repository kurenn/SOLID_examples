# A class should have only a single responsibility. - Wikipedia
# A class should have only one reason to change. - Robert C. Martin aka Uncle Bob

require 'net/http'
require 'json'

class ZipCodeServiceConfig
  def initialize(env:)
    @env = env
  end

  def base_url
    return 'https://myreal.server.com' if @env == 'production'

    'http://sepomex.icalialabs.com/api/v1'
  end
end

module RequestLogger
  def log(service_name, url, method = 'GET')
    puts "[#{service_name}] #{method} #{url}"
  end
end

class ResponseError < StandardError; end

class RequestHandler
  def perform(url)
    response = Net::HTTP.get_response(URI(url))
    raise ResponseError.new if response.code != '200'

    JSON.parse(response.body)
  end
end

class ZipCodeSerializer
  def initialize(params = {})
    @params = params
  end

  def serialize
    ZipCode.new(
      id: @params['id'],
      code: @params['d_codigo'],
      city: @params['d_ciudad'],
      state: @params['d_estado']
    )
  end
end

class ResponseSerializer
  SERIALIZERS = { zip_code: ZipCodeSerializer }.freeze

  def serialize(response, handler_name)
    response.map do |params|
      SERIALIZERS[handler_name].new(params).serialize
    end
  end
end

class ZipCodeService
  include RequestLogger

  def initialize(environment = 'development')
    @env = environment
  end

  def zip_codes
    log('ZipCodeService', url)

    response_serializer.serialize(response, :zip_code)
  end

  private

  attr_reader :env

  def url
    @url ||= "#{config.base_url}/zip_codes"
  end

  def response
    response ||= request_handler.perform(url)['zip_codes']
  end

  def response_serializer
    @response_serializer ||= ResponseSerializer.new
  end

  def request_handler
    @request_handler ||= RequestHandler.new
  end

  def config
    @config ||= ZipCodeServiceConfig.new(env: @env)
  end
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
