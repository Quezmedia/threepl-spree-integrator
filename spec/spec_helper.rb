ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'yaml'
require 'nutracoapi'
require 'awesome_print'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

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
