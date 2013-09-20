require 'savon'

class Nutracoapi::Base
  attr_reader :client
  attr_reader :last_response

  def initialize
    namespaces = { "xmlns:soapenv"=>"http://schemas.xmlsoap.org/soap/envelope/", "xmlns:vias"=>"http://www.JOI.com/schemas/ViaSub.WMS/" }
    @client = Savon.client(:wsdl => Nutracoapi.wsdl_endpoint,
                           :namespace_identifier => :vias,
                           :env_namespace => :soapenv,
                           :namespaces => namespaces,
                           :convert_request_keys_to => :camelcase,
                           :logger => Nutracoapi.logger,
                           :log => Nutracoapi.active_logs,
                           :ssl_verify_mode => :none)
  end

  private
  def prepare_message(message)
    message.merge Nutracoapi.login_parameters
  end

  def call(method, message = {})
    @last_response = @client.call(method, message: prepare_message(message))
  end
end
