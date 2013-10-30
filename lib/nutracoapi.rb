require 'rails'
require "active_record/railtie"
require 'nutracoapi/engine'
require 'logger'
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

  # To permit Rails style config initalizer
  class << self
    def config
      yield self
    end
  end
end
