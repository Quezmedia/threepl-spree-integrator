require "rails/generators"
require 'rails/generators/migration'
module Nutracoapi
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("../../templates", __FILE__)

      def self.next_migration_number(dirname)
        Time.now.strftime("%Y%m%d%H%M%S")
      end

      desc "Creates a Nutracoapi initializer in your application initializers directory."
      def copy_initializer
        template "nutracoapi.rb", "config/initializers/nutracoapi.rb"
      end

      desc "Generates the migration"
      def generate_migration
        migration_template "order_integrations.rb", File.join("db/migrate", "create_nutracoapi_order_integrations.rb")
        migration_template "add_canceled_at_to_nutracoapi_order_integrations.rb", File.join("db/migrate", "add_canceled_at_to_nutracoapi_order_integrations.rb")
      end

    end
  end
end
