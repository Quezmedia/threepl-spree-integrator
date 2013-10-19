class CreateNutracoapiOrderIntegrations < ActiveRecord::Migration
  def change
    create_table :nutracoapi_order_integrations do |t|

      t.timestamps
    end
  end
end
