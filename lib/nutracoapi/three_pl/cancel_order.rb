require 'nutracoapi/three_pl/base'
class Nutracoapi::ThreePl::CancelOrder < Nutracoapi::ThreePl::Base
  def call_cancel_order(warehouse_transaction_id)
    customer_id = ::Nutracoapi.login_parameters[:CustomerID]
    facility_id = ::Nutracoapi.login_parameters[:FacilityID]

    body = {:extLoginData => Nutracoapi.login_parameters}
    body = body.merge({
      :cancelOrders => {
        :CancelOrder => [
          :WarehouseTransactionID => warehouse_transaction_id,
          :reason => "Cancelling order"
        ]
      }
    })
    response = call("CancelOrders", {}, body)
    return parse_response(response.body)
  end

  private

  def parse_response(response_json)
    unless response_json[:fault].blank?
      raise Exception.new("#{response_json[:fault][:faultcode]} - #{response_json[:fault][:faultstring]} \n #{response_json[:fault][:detail]}")
    end
    response_json[:int32]
  end
end
