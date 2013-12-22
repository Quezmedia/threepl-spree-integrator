class AddCanceledAtToNutracoapiOrderIntegrations < ActiveRecord::Migration
  def change
    add_column :nutracoapi_order_integrations, :canceled_at, :datetime
  end
end
