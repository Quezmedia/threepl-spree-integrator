require 'nutracoapi/spree/base'
class Nutracoapi::Spree::ListOrders < Nutracoapi::Spree::Base
  def list_paid_orders
    params = { "q[state_eq]" => "complete", "q[payment_state_eq]" => "paid", "q[shipment_state_eq]" => "ready" }
    parse_response call("orders", params: params)
  end

  private

  def parse_response(response)
    json_response = JSON.parse(response.body)
    return [] if json_response["count"].to_i < 1
    parse_array json_response["orders"]
  end
end
