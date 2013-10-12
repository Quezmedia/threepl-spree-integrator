require 'savon'

class Nutracoapi::Base
  attr_reader :client
  attr_reader :last_response
  attr_reader :operation

  def initialize
    @client = Savon.new(Nutracoapi.wsdl_endpoint)
  end

  protected
  def prepare_operation(operation, header, body)
    @operation = @client.operation("ServiceExternal", "ServiceExternalSoap", operation)
    @operation.header = header
    @operation.body = body
    @operation.build
  end

  def call(operation, header, body)
    prepare_operation(operation, header, body)
    @last_response = @operation.call
  end
end
