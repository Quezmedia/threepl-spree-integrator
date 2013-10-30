# This migration comes from nutracoapi (originally 20131019003416)
class CreateNutracoapiOrderIntegrations < ActiveRecord::Migration
  def change
    create_table :nutracoapi_order_integrations do |t|

      t.string :order_number
      t.string :tracking_number
      t.string :shipment_number
      t.string :status, default: "integrated"
      t.datetime :shipped_at

      t.timestamps
    end
  end
end
