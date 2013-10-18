class Nutracoapi::Spree::ListOrders < Nutracoapi::Spree::Base
  def list_paid_orders
    params = { "q[state_eq]" => "complete", "q[payment_state_eq]" => "paid" }
    parse_response call("orders", params: params)
  end

  private
  def parse_order(json_order)
    order = OpenStruct.new
    json_order.each do |k,v|
      order.send("#{k.underscore}=", v.to_s)
    end
    order
  end

  def parse_response(response)
    json_response = JSON.parse(response.body)
    return [] if json_response["count"].to_i < 1
    array_response = Array.new
    json_response["orders"].each do |json_order|
      array_response << parse_order(json_order)
    end
    array_response
  end
end
