require 'nutracoapi/three_pl/base'
class Nutracoapi::ThreePl::FindOrder < Nutracoapi::ThreePl::Base
  def call_find_order(reference_num)
    customer_id = ::Nutracoapi.login_parameters[:CustomerID]
    facility_id = ::Nutracoapi.login_parameters[:FacilityID]

    body = {:userLoginData => Nutracoapi.login_parameters}
    body = body.merge({
      :focr => {
        :CustomerID => customer_id,
        :FacilityID => facility_id,
        :OverAlloc => "Any",
        :Closed => "Any",
        :ASNSent => "Any",
        :RouteSent => "Any",
        :DateRangeType => "Confirm",
        :ReferenceNum => reference_num
      }
    })
    response = call("FindOrders", {}, body)
    return parse_response(response)
  end

  private

  def parse_response(response)

    if response.body[:total_orders].to_i < 1
      return []
    end

    response_hash = Nori.new.parse(response.body[:find_orders])
    response_hash = response_hash["orders"]["order"]

    if response_hash.is_a?(Array)
      parse_array(response_hash)
    else
      [parse_hash(response_hash)]
    end
  end
end
