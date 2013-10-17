require 'yaml'
require 'nutracoapi'

RSpec.configure do |config|
  config.before(:all) do
    config_file_name = File.expand_path('config/login_parameters.yml', File.dirname(__FILE__))

    LOGIN_CONFIG ||= YAML.load_file(config_file_name)["test"]

    login_params = {:ThreePLID => LOGIN_CONFIG["three_plid"],
                    :ThreePLKey => LOGIN_CONFIG["three_plkey"],
                    :Login => LOGIN_CONFIG["login"],
                    :Password => LOGIN_CONFIG["password"],
                    :CustomerID =>  LOGIN_CONFIG["customer_id"],
                    :FacilityID => LOGIN_CONFIG["facility_id"]}

    Nutracoapi.config do |config|
      config.login_parameters = login_params
    end
  end
end
