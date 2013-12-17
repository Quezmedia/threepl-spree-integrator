ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'shoulda-matchers'
require 'rspec/autorun'
require 'yaml'
require 'nutracoapi'
require 'awesome_print'
require 'database_cleaner'

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

  config.before(:suite) do
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
      config.spree_endpoint   = LOGIN_CONFIG["spree_endpoint"]
      config.spree_token      = LOGIN_CONFIG["spree_token"]
    end

    # Clean all tables to start
    DatabaseCleaner.clean_with :truncation
    # Use transactions for tests
    DatabaseCleaner.strategy = :transaction

    Rails.logger = Logger.new(STDOUT)
  end

  config.before(:each) do
    # Start transaction for this test
    DatabaseCleaner.start
  end

  config.after(:each) do
    # Rollback transaction
    DatabaseCleaner.clean
  end
end
