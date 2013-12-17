require 'savon'

class Nutracoapi::ThreePl::Base
  attr_reader :client
  attr_reader :last_response
  attr_reader :operation

  def initialize
    @client = Savon.new(Nutracoapi.wsdl_endpoint)
  end

  protected
  def parse_array(array_obj)
    result = Array.new
    array_obj.each do |obj|
      result << parse_hash(obj)
    end
    result
  end

  def parse_hash(hash_obj)
    response_object = OpenStruct.new
    hash_obj.each do |k,v|
      response_object.send("#{ k.underscore }=", v.to_s)
    end

    response_object
  end

  def prepare_operation(operation, header, body)
    @operation = @client.operation("ServiceExternal", "ServiceExternalSoap", operation)
    @operation.header = header
    @operation.body = body
    @operation.build
  end

  def call(operation, header, body)
    Nutracoapi.logger.info "ThreePl::Base::call - Starting"
    #Nutracoapi.logger.info "Operation: #{operation}"
    #Nutracoapi.logger.info "Header: #{header}"
    #Nutracoapi.logger.info "Body: #{operation}"

    prepare_operation(operation, header, body)
    @last_response = @operation.call
  end
end
