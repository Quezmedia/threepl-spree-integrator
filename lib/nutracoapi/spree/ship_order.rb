require 'nutracoapi/spree/base'
class Nutracoapi::Spree::ShipOrder < Nutracoapi::Spree::Base
  def ship_order(order_number, shipment_number, tracking_number)
    parse_response call(
      "orders/#{order_number.to_s}/shipments/#{shipment_number}/ship",
      method: :put, params: {'shipment[tracking]' => tracking_number}
    )
  end
end
