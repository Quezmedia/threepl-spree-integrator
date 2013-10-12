require 'savon'

class Nutracoapi::Base
  attr_reader :client
  attr_reader :last_response

  def initialize
    namespaces = { "xmlns:soapenv"=>"http://schemas.xmlsoap.org/soap/envelope/", "xmlns:vias"=>"http://www.JOI.com/schemas/ViaSub.WMS/" }
    @client = Savon.client(:wsdl => Nutracoapi.wsdl_endpoint,
                           :pretty_print_xml => true,
                           :namespace_identifier => :vias,
                           :env_namespace => :soapenv,
                           :namespaces => namespaces,
                           :convert_request_keys_to => :none,
                           :logger => Nutracoapi.logger,
                           :log => Nutracoapi.active_logs,
                           :ssl_verify_mode => :none)
  end

  protected
  def call(method, message = {})
    @last_response = @client.call(method, message: prepare_message(message))
  end

  private
  def prepare_message(message)
    message.merge Nutracoapi.login_parameters
  end
end
