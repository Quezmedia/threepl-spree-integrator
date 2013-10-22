# This migration comes from nutracoapi (originally 20131019003416)
class CreateNutracoapiOrderIntegrations < ActiveRecord::Migration
  def change
    create_table :nutracoapi_order_integrations do |t|

      t.timestamps
    end
  end
end
