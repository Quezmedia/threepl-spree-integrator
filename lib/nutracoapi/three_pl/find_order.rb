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
    parsed_response = parse_response(response)
    return {:total_orders => response.body[:total_orders].to_i, :parsed_response => parsed_response}
  end

  private
  def parse_response(response)

    if response.body[:total_orders].to_i < 1
      return nil
    end

    response_hash = Nori.new.parse(response.body[:find_orders])
    response_hash = response_hash["orders"]["order"]

    response_object = OpenStruct.new
    response_hash.each do |k,v|
      response_object.send("#{ k.underscore }=", v.to_s)
    end

    response_object
  end
end
