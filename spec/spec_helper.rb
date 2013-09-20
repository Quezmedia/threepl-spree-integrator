require 'yaml'
require 'nutracoapi'

RSpec.configure do |config|
  config.before(:all) do
    config_file_name = File.expand_path('config/login_parameters.yml', File.dirname(__FILE__))

    LOGIN_CONFIG ||= YAML.load_file(config_file_name)["test"]

    login_params = {:ThreePLID => LOGIN_CONFIG["three_plid"],
                    :Login => LOGIN_CONFIG["login"],
                    :Password => LOGIN_CONFIG["password"]}

    Nutracoapi.config do |config|
      config.login_parameters = login_params
      config.active_logs = false
    end
  end
end
