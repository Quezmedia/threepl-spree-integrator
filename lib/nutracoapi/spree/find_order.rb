require 'nutracoapi/spree/base'
class Nutracoapi::Spree::FindOrder < Nutracoapi::Spree::Base
  def find_order(order_number)
    parse_response call("orders/#{order_number.to_s}", params: {})
  end
end
