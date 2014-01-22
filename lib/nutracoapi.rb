require 'rails'
require "active_record/railtie"
require 'nutracoapi/engine'
require 'logging'
Dir["#{ File.expand_path(File.dirname(__FILE__)) }/nutracoapi/*.rb"].each{|f| require f}

module Nutracoapi
  mattr_accessor :login_parameters
  @@login_parameters = {:ThreePLID => 111, :Login => "xxxxxxx", :Password => "xxxxxxx", :ThreePLKey =>"xxxxxxxxxxxxx", :FacilityID => "0", :CustomerID => "0"}

  mattr_accessor :wsdl_endpoint
  @@wsdl_endpoint = "https://app02.3plcentral.com/webserviceexternal/contracts.asmx?WSDL"

  mattr_accessor :spree_endpoint
  @@spree_endpoint = "http://example.com/api"

  mattr_accessor :spree_token
  @@spree_token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"


  # Log system
  Logging.init :debug, :info, :warn, :error, :fatal
  layout = Logging::Layouts::Pattern.new :pattern => "[%d] [%-5l] %m\n"
  default_appender = Logging::Appenders::RollingFile.new 'default',
    :filename => "log/starapi.log", :age => 'daily', :keep => 30, :safe => true, :layout => layout

  mattr_accessor :logger
  @@logger = Logging::Logger[:root]
  @@logger.add_appenders default_appender
  @@logger.level = 0

  # To permit Rails style config initalizer
  class << self
    def config
      yield self
    end
  end
end
